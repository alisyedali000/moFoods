//
//  CustomTextField.swift
//  MoFoods
//
//  Created by Syed Ahmad  on 03/02/2025.
//

import SwiftUI
import SwiftUI

struct CustomTextField: View {
    
    var placeholder : String
    @Binding var value : String
    var isSecure : Bool?
    
    var body: some View {
        Group {
            isSecure ?? false ? AnyView(secureTF()) : AnyView(normalTF())

        }
        

    }
}

extension CustomTextField{
    
    func normalTF() -> some View{
        VStack(alignment: .leading,spacing: 10){
            Text(placeholder)
                .font(.semiBold(size: 16))
           
            HStack{
                TextField(placeholder, text: $value)
                    .font(.regular(size: 16))
                    .padding()
                    .addStroke(radius: 8, color: .lightGray, lineWidth: 1)
                
                 
            }
        }
    }
    
    
    func secureTF() -> some View{
        VStack(alignment: .leading,spacing: 10){
            Text(placeholder)
                .font(.semiBold(size: 16))
           
            HStack{
                SecureField(placeholder, text: $value)
                    .font(.regular(size: 16))
                    .padding()
                    .addStroke(radius: 8, color: .lightGray, lineWidth: 1)

                
                 
            }
        }
    }
    

    
}

#Preview {
    CustomTextField(placeholder: "Placeholder", value: .constant("hello"))
}
