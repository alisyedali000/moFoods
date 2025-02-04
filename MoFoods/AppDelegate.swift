//
//  AppDelegare.swift
//  MoFoods
//
//  Created by Syed Ahmad  on 04/02/2025.
//

import Foundation
import FirebaseCore
import UIKit
import UserNotifications



import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        FirebaseApp.configure()

        
        return true
    }
    
}

