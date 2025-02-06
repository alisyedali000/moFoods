//
//  TabBar.swift
//  MoFoods
//
//  Created by Syed Ahmad  on 06/02/2025.
//


import SwiftUI
import FirebaseAuth

struct TabBar: View {
    
    @State private var tabSelection = 1
    @State var showPaywall = false
    
    @StateObject var appleSignIn = AppleSignIn()
    @StateObject var gooleSignIn = GoogleSignIn()
    @StateObject var vm = AuthViewModel()
    
    init() {
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(Color.white)
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor(.primaryOrange)
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(.primaryOrange)]
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor(Color.gray)
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(Color.gray)]
//        tabBarAppearance.shadowImage = nil
//        tabBarAppearance.shadowColor = nil

        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        

        
    }
    
    var body: some View {

        NavigationStack{
            tabBar
                .onAppear(){
                    self.showPaywall = true
                }
                .fullScreenCover(isPresented: $showPaywall) {
                    
                    HStack{
                        
                        Text("Paywall")
                        
                        Button{
                            self.showPaywall = false
                        }label: {
                            
                            Text("Dismiss")
                            
                        }
                        
                    }
                    
                    
                }
        }

    }

    
}

extension TabBar {
    
    var tabBar: some View {
        
        TabView(selection: $tabSelection){
            
            Text("Home - Tap to Logout")
                .onTapGesture {
                    
                    appleSignIn.signOut()
                    gooleSignIn.signOut()
                    vm.logout()
                    
                    UserDefaultManager.shared.removeUser()
                    changeRootView(to: ContentView())
                    
                }
                .tabItem {
                    
                    withAnimation(.linear(duration: 0.5)) {
                        
                        Label{
                            
                            Text("Home")
                            
                        } icon: {
                            
                            ImageName.home
                                .renderingMode(.template)
                            
                            
                        }
                        
                    }
                    
                    
                }
                .tag(1)
            
            
            Text("Discover")
                .tabItem {
                    
                    withAnimation(.linear(duration: 0.5)) {
                        
                        Label{
                            
                            Text("Discover")
                            
                        } icon: {
                            
                            ImageName.discover
                                .renderingMode(.template)
                            
                            
                        }
                        
                    }
                    
                    
                }
                .tag(2)
            
            Text("Pin")
                .tabItem {
                    
                    withAnimation(.linear(duration: 0.5)) {
                        
                        Label{
                            
                            Text("Pin")
                            
                        } icon: {
                            
                            ImageName.pin
                                .renderingMode(.template)
                            
                            
                        }
                        
                    }
                    
                    
                }
                .tag(3)
            
            
            Text("Groups")
                .tabItem {
                    
                    withAnimation(.linear(duration: 0.5)) {
                        
                        Label{
                            
                            Text("Groups")
                            
                        } icon: {
                            
                            ImageName.groups
                                .renderingMode(.template)
                            
                            
                        }
                        
                    }
                    
                    
                }
                .tag(4)
            
            Text("Account")
                .tabItem {
                    
                    withAnimation(.linear(duration: 0.5)) {
                        
                        Label{
                            
                            Text("Account")
                            
                        } icon: {
                            
                            ImageName.profile
                                .renderingMode(.template)
                            
                            
                        }
                        
                    }
                    
                    
                }
                .tag(5)
            
        }
        
    }
    
}

#Preview {
    TabBar()
        
}
