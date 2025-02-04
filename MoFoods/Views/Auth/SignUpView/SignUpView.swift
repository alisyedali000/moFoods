//
//  LoginView.swift
//  MoFoods
//
//  Created by Syed Ahmad  on 04/02/2025.
//


import SwiftUI

struct SignUpView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @StateObject var vm = AuthViewModel()

    var body: some View {
        screenView
            .padding(.horizontal)
            .addOnboardingHeader
            .alert("MoFoods", isPresented: $vm.showError) {
                Button("OK"){
                    
                }
            } message: {
                Text(vm.errorMessage)
            }
    }
}

extension SignUpView{
    
    var screenView: some View {
        
        ScrollView(showsIndicators: false){
            
            VStack(spacing: 20){
                
                headerText
                    .padding(.top, 40)
                
                socialLogins
                
                orView
                
                textFields
                
                AppButton(title: "Create new account") {
                    vm.signUp()
                }
                
                signInNavigation
            }
        }
        
    }
    
}

extension SignUpView{
    
    var headerText : some View {
        
        VStack(alignment: .leading, spacing: 20){
            
            HStack{
                
                Text("Sign Up")
                    .font(.semiBold(size: 32))
                
                Spacer()
                
            }
            
            HStack{
                
                Text("Create an account to start pinning restaurants")
                    .font(.regular(size: 20))
                    .foregroundStyle(Color.gray)
                
                Spacer()
            }
        }
        
    }
    
    
    var socialLogins: some View {
        
        VStack{
            
            SocialLoginButton(icon: ImageName.googleIcon, title: "Sign in with Google") {
                
            }
            
            
            SocialLoginButton(icon: ImageName.appleIcon, title: "Sign in with Apple") {
                
            }
        }
        
    }
    
    var textFields: some View {
        
        VStack(spacing: 10){
            
            CustomTextField(placeholder: "Name", value: $vm.userName)
            
            CustomTextField(placeholder: "Email", value: $vm.email)
            
            CustomTextField(placeholder: "Password", value: $vm.password, isSecure: true)
            
        }
    }
    
    var orView: some View {
        
        ZStack{
            
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(Color.lightGray)
            
            Text("OR")
                .font(.regular(size: 14))
                .foregroundStyle(Color.lightGray)
                .padding()
                .background(
                    
                    RoundedRectangle(cornerRadius: 1)
                        .foregroundStyle(colorScheme == .dark ? Color.black : Color.white)
                    
                )
            
        }
        
    }

    
    var signInNavigation: some View {
        
        HStack(spacing: 0){
            
            Text("Already have an account yet? ")
                .font(.regular(size: 16))
                
            Button{
                
                self.presentationMode.wrappedValue.dismiss()
                
            }label: {
                
                Text("Sign In")
                    .font(.medium(size: 16))
                    .foregroundStyle(Color.primaryOrange)
                
            }
            
        }
        
    }
}

#Preview {
    SignUpView()
}
