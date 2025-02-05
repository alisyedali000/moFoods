//
//  GetStartedView.swift
//  MoFoods
//
//  Created by Syed Ahmad  on 05/02/2025.
//

import SwiftUI

struct GetStartedView: View {
    @State var moveNext = false
    var body: some View {
        screenView
            .navigationDestination(isPresented: $moveNext) {
                
                PostOnboardingViewer()
                    .navigationBarBackButtonHidden()
                
            }
    }
}

extension GetStartedView{
    
    var screenView: some View {
        
        
        ZStack(alignment: .bottom){
            
            image
            
            Rectangle()
                .foregroundStyle(Color.black)
                .frame(height: UIScreen.main.bounds.height * 0.32)
                .overlay {
                    
                    textAndNavigation
                        .padding(.horizontal)
                    
                }
        }
    }
    
    
}

extension GetStartedView{
    
    var image: some View {
        
        ImageName.pOnboarding1
            .resizable()
            .scaledToFill()
            .clipped()
            .clipShape(.rect)
            .frame(width: UIScreen.main.bounds.width)
            .ignoresSafeArea()
        
    }
    
    var textAndNavigation: some View {
        
        VStack(alignment: .leading, spacing:20){
            
            Text("Find ")
                .italic(true)
                .foregroundStyle(Color(hex: "#FD8719"))
                .font(.largeTitle)
                .fontWeight(.bold)
            +
            Text("places to\neat with AI\nrecommendations")
                .font(.bold(size: 35))
                .foregroundStyle(Color.white)
            
            
            AppButton(title: "Get Started", radius: 53) {
                self.moveNext.toggle()
            }
        }
        
        
    }
}

#Preview {
    GetStartedView()
}
