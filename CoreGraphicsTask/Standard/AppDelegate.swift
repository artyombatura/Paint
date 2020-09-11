//
//  AppDelegate.swift
//  CoreGraphicsTask
//
//  Created by Artsiom Batura on 9/8/20.
//  Copyright © 2020 Artsiom Batura. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let mainViewController = ViewController()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

}

