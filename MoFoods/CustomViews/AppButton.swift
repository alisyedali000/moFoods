//
//  AppButton.swift
//  MoFoods
//
//  Created by Syed Ahmad  on 03/02/2025.
//

import SwiftUI

struct AppButton: View {
    var title: String
    var radius: CGFloat?
    var action: () -> Void
    
    var body: some View {
        Button{
            
            self.action()
            
        }label: {
            
            ZStack{
                RoundedRectangle(cornerRadius: radius ?? 8.0)
                    .frame(height: 54)
                    .foregroundStyle(Color.primaryOrange)
                
                Text(title)
                    .font(.bold(size: 16))
                    .foregroundStyle(Color.white)
            }
        }
    }
}

#Preview {
    AppButton(title: "Get Started"){
        
    }
}
