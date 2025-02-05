//
//  OnboardingView.swift
//  MoFoods
//
//  Created by Syed Ahmad  on 05/02/2025.
//


import SwiftUI

struct PostOnboardingView: View {

    var image : Image
    var title : String
    var description: String
    
    var body: some View {
        screenView

    }
    
    
}

extension PostOnboardingView{
    
    var screenView : some View {
        
        VStack{


                
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.60)
                    .clipped()
                    .clipShape(.rect)
                    .ignoresSafeArea()

         
            VStack(spacing: 20){
                
                Text(title)
                    .font(.bold(size: 24))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                
                Text(description)
                    .font(.regular(size: 16))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .foregroundStyle(Color.gray)
                
            }
            
            Spacer()
            
            
        }
        
        
    }
    
}
#Preview {
    PostOnboardingView(image: ImageName.pOnboarding2, title: "Access to location 📍", description: "Enable location sharing to discover new places to eat.")
}
