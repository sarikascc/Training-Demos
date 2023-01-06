//
//  AppDelegate.swift
//  TabBarDemo
//
//  Created by Sarika scc on 06/01/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "mainTab") as! UITabBarController
        vc.selectedIndex = 0 // 1
        appDelegate.window?.rootViewController = vc
        appDelegate.window?.makeKeyAndVisible()
        
        return true
    }
    
}

