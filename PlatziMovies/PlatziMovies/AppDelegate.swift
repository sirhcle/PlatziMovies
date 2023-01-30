//
//  AppDelegate.swift
//  PlatziMovies
//
//  Created by christian hernandez rivera on 26/01/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        let navcontroller = UINavigationController()
        navcontroller.viewControllers = [HomeViewController()]
        navcontroller.navigationBar.isHidden = true
        window = UIWindow()
        window?.rootViewController = navcontroller
        window?.makeKeyAndVisible()
        window?.backgroundColor = Colors().platziBackground
        
        return true
    }

}

