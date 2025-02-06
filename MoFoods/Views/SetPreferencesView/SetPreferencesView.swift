//
//  SetPreferencesView.swift
//  MoFoods
//
//  Created by Syed Ahmad  on 05/02/2025.
//

import SwiftUI

struct SetPreferencesView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var selectedPreferences = Preferences()
    @State var showSavedSheet = false
    var body: some View {
        screenView
            .padding(.horizontal)
            .fullScreenCover(isPresented: $showSavedSheet) {
                self.presentationMode.wrappedValue.dismiss()
            } content: {
                PreferencesSavedView()
                    .navigationBarBackButtonHidden()
            }
        
    }
}

extension SetPreferencesView{
    
    var screenView : some View{
        
        VStack{
            
            Text("Select Preferences")
                .font(.bold(size: 20))
            ScrollView(showsIndicators: false){
                
                PreferenceSection(title: "Ambiance", options: preferences.ambiance, selectedItems: $selectedPreferences.ambiance)
                
                PreferenceSection(title: "Preffered Cuisine", options: preferences.prefferedCuisine, selectedItems: $selectedPreferences.prefferedCuisine)
                
                PreferenceSection(title: "Allergies", options: preferences.allergies, selectedItems: $selectedPreferences.allergies)
                
                Divider()
                
                distanceSlider
                
                AppButton(title: "Save Preferences") {
                    if selectedPreferences != Preferences(){
                        DatabaseManager.shared.updateUserPreferences(preferences: self.selectedPreferences)
                        
                        self.showSavedSheet.toggle()
                    } else {
                        debugPrint("Please select one or more!")
                    }
                }
            }
        }
    }
    
}

extension SetPreferencesView{
    
    var distanceSlider: some View{
        
        VStack(alignment: .leading){
            
            Text("Distance")
                .font(.semiBold(size: 16))
            
            Slider(value: $selectedPreferences.distance, in: 0...10) {
                
            }.padding(.horizontal,5)
                .tint(.primaryOrange)
            
            HStack{
                
                Text(String(format: "%.1f mi", selectedPreferences.distance))
                    .font(.semiBold(size: 16))
                
                Spacer()
                
                Text("10 mi")
                    .font(.semiBold(size: 16))
                
            }
            
            
        }
        
    }
    
}

#Preview {
    SetPreferencesView()
}
