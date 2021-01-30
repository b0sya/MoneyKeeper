//
//  AppDelegate.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 06.01.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        let navigation = UINavigationController(rootViewController: ModuleFactory().makeMainModule())
        navigation.navigationBar.prefersLargeTitles = true
        window?.rootViewController = UINavigationController(rootViewController: ModuleFactory().makeMainModule())
        window?.makeKeyAndVisible()
        
        return true
    }


}

