//
//  OboradingView.swift
//  MoFoods
//
//  Created by Syed Ahmad  on 04/02/2025.
//

import SwiftUI

struct OnboardingView: View {

    var image : Image
    var title : String
    var description: String
    
    var body: some View {
        screenView

    }
    
    
}

extension OnboardingView{
    
    var screenView : some View {
        
        ZStack(alignment: .center){
            
            ZStack{
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
                    .clipShape(.rect)
                    .overlay {
                        LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)
                            .clipped()
                            .clipShape(.rect)
                    }
                    .ignoresSafeArea()
            }
            VStack(spacing: 20){
                
                Text(title)
                    .font(.bold(size: 24))
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Text(description)
                    .font(.regular(size: 16))
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
            }
            .offset(y: 120)
            
        }
        
        
    }
    
}
#Preview {
    OnboardingView(image: ImageName.onboarding1, title: "Welcome to MoFoods", description: "Your ultimate food companion. Save all your favorite food spots and explore new ones.")
}
