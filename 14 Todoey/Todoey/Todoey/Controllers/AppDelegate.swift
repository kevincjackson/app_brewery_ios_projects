//
//  AppDelegate.swift
//  Todoey
//
//  Created by Kevin Jackson on 1/22/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Initialize Realm Database
        do {
            _ = try Realm()
        }
        catch {
            print("Error initializing Realm: \(error)")
        }

        return true
    }
}

