//
//  SocialLoginButton.swift
//  MoFoods
//
//  Created by Syed Ahmad  on 04/02/2025.
//


import SwiftUI

struct SocialLoginButton: View {
    var icon: Image
    var title: String
    var action: () -> Void
    
    var body: some View {
        screenView
    }
}

extension SocialLoginButton {
    
    var screenView : some View {
        
        
        
        Button{
            
            self.action()
            
        }label: {
            
            ZStack{
                
                RoundedRectangle(cornerRadius: 8)
                    .frame(height: 56)
                    .foregroundStyle(icon == ImageName.appleIcon ? Color.black : Color.white)
                    .addStroke(radius: 8, color: .lightGray, lineWidth: 1)
                HStack(spacing: 20){
                
                    icon
                    
                    Text(title)
                        .font(.semiBold(size: 20))
                        .foregroundStyle(icon == ImageName.appleIcon ? Color.white : Color.black)
                }
                
            }
            
        }
        
        
        
    }
    
}

#Preview {
    SocialLoginButton(icon: ImageName.appleIcon, title: "Sign in With Google"){
        
    }
}
