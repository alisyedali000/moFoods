//
//  LoaderView.swift
//  MoFoods
//
//  Created by Syed Ahmad  on 06/02/2025.
//

import SwiftUI

struct LoaderView: View {
    
    var body: some View {
        
        ZStack{
            
            Rectangle()
                .foregroundStyle(Color.black.opacity(0.3))
                .ignoresSafeArea()
            
            ProgressView()
                .scaleEffect(1)
            
        }
    }
}

#Preview {
    LoaderView()
}
