//
//  SetPreferencesView.swift
//  MoFoods
//
//  Created by Syed Ahmad  on 05/02/2025.
//

import SwiftUI

struct SetPreferencesView: View {
    @State var selectedPreferences = Preferences()
    var body: some View {
        screenView
            .padding(.horizontal)

    }
}

extension SetPreferencesView{
    
    var screenView : some View{
        
        VStack{
            
            ScrollView(showsIndicators: false){
                
                PreferenceSection(title: "Ambiance", options: preferences.ambiance, selectedItems: $selectedPreferences.ambiance)
                
                PreferenceSection(title: "Preffered Cuisine", options: preferences.prefferedCuisine, selectedItems: $selectedPreferences.prefferedCuisine)
                
                PreferenceSection(title: "Allergies", options: preferences.allergies, selectedItems: $selectedPreferences.allergies)
                
                
                AppButton(title: "Save") {
                    DatabaseManager.shared.updateUserPreferences(preferences: self.selectedPreferences)
                }
            }
        }
    }
    
}

#Preview {
    SetPreferencesView()
}
