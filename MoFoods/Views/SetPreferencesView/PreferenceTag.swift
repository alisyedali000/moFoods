//
//  CategoryTag.swift
//  MoFoods
//
//  Created by Syed Ahmad  on 05/02/2025.
//


import SwiftUI

struct PreferenceTag: View {
    @Binding var isSelected: Bool
    var title : String
    var action : () -> Void
    var body: some View {
        screenView
    }
}

extension PreferenceTag{
    
    var screenView: some View {
        
        Button{
            
            self.action()
            
        }label: {
            
            Text(title)
                .font(.regular(size: 14))
                .padding(.horizontal)
                .foregroundStyle(Color.black)
                .padding(.vertical,10)
                .background(
                    
                    RoundedRectangle(cornerRadius: 33)
                        .foregroundStyle(isSelected ? Color.primaryOrange.opacity(0.3) : Color.lightGray.opacity(0.4))
                        .frame(height: 35)
                    
                )
            
                .addStroke(radius: 33, color:  .primaryOrange, lineWidth: isSelected ? 1 : 0)
            
            
        }
        
    }
}

#Preview {
    PreferenceTag(isSelected: .constant(false), title: "Hello"){
        
    }
}
