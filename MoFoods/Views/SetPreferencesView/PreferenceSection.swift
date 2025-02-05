//
//  PreferenceSection.swift
//  MoFoods
//
//  Created by Syed Ahmad  on 05/02/2025.
//

import SwiftUI

struct PreferenceSection: View {
    let title: String
    let options: [String]
    @Binding var selectedItems: [String]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text(title)
                .font(.headline)
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack {
                    
                    ForEach(options, id: \.self) { option in
                        PreferenceTag(
                            isSelected: .constant(selectedItems.contains(option)),
                            title: option
                        ) {
                            if selectedItems.contains(option) {
                                selectedItems.removeAll { $0 == option }
                            } else {
                                selectedItems.append(option)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview{
    PreferenceSection(title: "Ambiance", options: ["Rooftop", "Open"], selectedItems: .constant(["Rooftop"]))
}
