//
//  AppDelegate.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 06.01.2021.
//

import CoreData
import UIKit
import Firebase

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
        
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")

        applicationCoordinator = makeCoordinator()
        applicationCoordinator?.start()
        window?.makeKeyAndVisible()
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        StorageProvider.shared.saveContext()
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

