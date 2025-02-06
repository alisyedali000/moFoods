//
//  PreferencesSavedView.swift
//  MoFoods
//
//  Created by Syed Ahmad  on 06/02/2025.
//

import SwiftUI

struct PreferencesSavedView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        screenView
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    presentationMode.wrappedValue.dismiss()
                }
            }
    }
}

extension PreferencesSavedView{
    
    var screenView : some View {
        
        VStack{
            
            Text("Preferences Saved")
                .font(.bold(size: 20))
            
            Spacer()
            
            ImageName.savedIcon
            Text("Preferences Saved")
                .font(.semiBold(size: 18))
            Spacer()
            
        }
        
    }
    
}

#Preview {
    PreferencesSavedView()
}
