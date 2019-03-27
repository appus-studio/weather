//
//  AppDelegate.swift
//  weather
//
//  Created by Alexey Kubas on 3/26/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        Auth.auth().signInAnonymously(completion: nil)
        
        Session.current.startUpdatingLocation()

        return true
    }
}
