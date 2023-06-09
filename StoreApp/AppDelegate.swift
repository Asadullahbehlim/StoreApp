//
//  AppDelegate.swift
//  StoreApp
//
//  Created by Asadullah Behlim on 13/04/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        window?.rootViewController = UINavigationController(rootViewController: CategoriesTableViewController())

        return true

//        let navController = UINavigationController(rootViewController: CategoriesTableViewController())
//        let window = UIWindow(frame: UIScreen.main.bounds)
//        window.rootViewController = navController
//        window.makeKeyAndVisible()
//        self.window = window
//
//        return true
//
        
    }
}
