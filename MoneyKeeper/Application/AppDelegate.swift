//
//  AppDelegate.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 06.01.2021.
//

import CoreData
import UIKit
import Firebase
import GoogleSignIn
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? {
        didSet {
            window?.rootViewController = MKNavigationController()
        }
    }

    private var applicationCoordinator: Coordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        
        FirebaseApp.configure()
        
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")

        applicationCoordinator = makeCoordinator()
        applicationCoordinator?.start()
        window?.makeKeyAndVisible()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        CoreDataStorage.shared.saveContext()
    }

    private func makeCoordinator() -> Coordinator? {
        guard let rootController = window?.rootViewController as? UINavigationController else {
            return nil
        }
        return ApplicationCoordinator(
          router: RouterImp(rootController: rootController),
          coordinatorFactory: CoordinatorFactory()
        )
    }
}

