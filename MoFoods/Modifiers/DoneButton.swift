//
//  DoneButton.swift
//  MoFoods
//
//  Created by Syed Ahmad  on 03/02/2025.
//

import Foundation
import SwiftUI

extension View {

       var addDoneButton: some View {
        modifier(DoneButton())
    }
}
struct DoneButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                    Button("Done") {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                    .foregroundStyle(.blue)
                    .padding(.trailing, 20)
                }
            }
    }
}

extension UIApplication {
    
    func removeResponder() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
