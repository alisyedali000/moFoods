//
//  LoginView.swift
//  MoFoods
//
//  Created by Syed Ahmad  on 04/02/2025.
//

import SwiftUI

struct LoginView: View {
    @StateObject var appleSignIn = AppleSignIn()
    @StateObject var googleSignIn = GoogleSignIn()
    @StateObject var vm = AuthViewModel()
    @State var moveNext = false
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        
        ZStack{
            
            screenView
                .padding(.horizontal)
                .addOnboardingHeader
                .adaptsToKeyboard
                .addDoneButton

            
            if vm.showLoader || appleSignIn.showLoader || googleSignIn.showLoader {
                
                LoaderView()
                
            }
        }
            .alert("MoFoods", isPresented: $vm.showError) {
                Button("OK"){
                    
                }
            } message: {
                Text(vm.errorMessage)
            }
            .navigationDestination(isPresented: $moveNext) {
                
                GetStartedView()
                    .navigationBarBackButtonHidden()
                
            }


    }
}

extension LoginView{
    
    var screenView: some View {
        
        VStack(spacing: 20){
            
            headerText
                .padding(.top, 40)
        
            socialLogins

            orView
            
            textFields
            
            AppButton(title: "Log In") {
                vm.login(){ isFirstLogin in
                    
                    if isFirstLogin{
                        self.moveNext.toggle()
                    }
                }
            }
            
            signUpNavigation
        }
        
    }
    
}

extension LoginView{
    
    var headerText : some View {
        
        VStack(alignment: .leading, spacing: 20){
            Text("Login")
                .font(.semiBold(size: 32))
            
            Text("Log in to your account and start pinning restaurants")
                .font(.regular(size: 20))
                .foregroundStyle(Color.gray)
        }
        
    }
    
    
    var socialLogins: some View {
        
        VStack{
            
            SocialLoginButton(icon: ImageName.googleIcon, title: "Sign in with Google") {
                
                googleSignIn.signIn(){ isFirstLogin in
                    
                    if isFirstLogin{
                        
                        self.moveNext.toggle()
                        
                    }
                    
                }
                
            }
            
            
            SocialLoginButton(icon: ImageName.appleIcon, title: "Sign in with Apple") {
                
                appleSignIn.signIn { isFirstLogin in
                    if isFirstLogin{

                        self.moveNext.toggle()
                        
                    }
                }
                
            }
        }
        
    }
    
    var textFields: some View {
        
        VStack(spacing: 10){
            
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
    
    
    var signUpNavigation: some View {
        
        HStack(spacing: 0){
            
            Text("Don’t have an account yet? ")
                .font(.regular(size: 16))
                
            NavigationLink{
                
                SignUpView()
                    .navigationBarBackButtonHidden()
                
            }label: {
                
                Text("Sign Up")
                    .font(.medium(size: 16))
                    .foregroundStyle(Color.primaryOrange)
                
            }
            
        }
        
    }
}

#Preview {
    LoginView()
}
