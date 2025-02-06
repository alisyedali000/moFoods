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

func changeRootView<NewRoot: View>(to view: NewRoot) {
    if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
        if let window = scene.windows.first {
            window.rootViewController = UIHostingController(rootView: view)
            window.makeKeyAndVisible()
        }
    }
}
