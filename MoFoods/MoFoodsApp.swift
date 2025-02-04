//
//  MoFoodsApp.swift
//  MoFoods
//
//  Created by Syed Ahmad  on 03/02/2025.
//

import SwiftUI
import Firebase

@main
struct MoFoodsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                ContentView()
            }
        }
    }
}
