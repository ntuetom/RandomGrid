//
//  AppDelegate.swift
//  RandomGrid
//
//  Created by Wu hung-yi on 2024/4/9.
//  Copyright © 2024 Wu. All rights reserved.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initView()
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func initView() {
        if window == nil {
            window = UIWindow.init(frame: UIScreen.main.bounds)
            window?.backgroundColor = .white
            window?.rootViewController = UINavigationController(rootViewController: GridViewController(row: 1, column: 1))
            window?.makeKeyAndVisible()
        }
    }

}

