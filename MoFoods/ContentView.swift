//
//  ContentView.swift
//  MoFoods
//
//  Created by Syed Ahmad  on 03/02/2025.
//

import SwiftUI

struct ContentView: View {

        @AppStorage("isAuthenticated") var isAuthenticated = UserDefaultManager.IsAuthenticated()
    
        var body: some View {
            NavigationStack{
                Group {

                    OnboardingViewer()
                    
                }
            }.onAppear(){
                    
                    if isAuthenticated{
                        
                        changeRootView(to: TabBar())
                        
                    }
                
            }
            .onReceive(UserDefaultManager.Authenticated) { newValue in
                DispatchQueue.main.async{
                    
                    isAuthenticated = newValue
                    if newValue{

                        changeRootView(to: TabBar())

                    } else {
                        
                        changeRootView(to: ContentView())
                        
                    }
                }
            }
        
    }
}

#Preview {
    ContentView()
}

