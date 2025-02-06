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
    @StateObject var appleSignIn = AppleSignIn()
    @StateObject var googleSignIn = GoogleSignIn()
    @State var moveNext = false
    
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
                    vm.signUp(){ _ in
                        self.moveNext.toggle()
                    }
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
            
            SocialLoginButton(icon: ImageName.googleIcon, title: "Sign up with Google") {
                
                googleSignIn.signIn(){ isFirstLogin in
                    
                    if isFirstLogin{
                        
                        self.moveNext.toggle()
                        
                    }
                    
                }
                
            }
            
            
            SocialLoginButton(icon: ImageName.appleIcon, title: "Sign up with Apple") {
                
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
