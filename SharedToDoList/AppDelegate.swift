//
//  AppDelegate.swift
//  SharedToDoList
//
//  Created by Nikhil Trivedi on 1/4/19.
//  Copyright © 2019 Nikhil Trivedi. All rights reserved.
//

import UIKit
import Firebase
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }

}

