//
//  AuthViewModel.swift
//  MoFoods
//
//  Created by Syed Ahmad  on 04/02/2025.
//

import SwiftUI
import FirebaseAuth

class AuthViewModel: ViewModel {
    @Published var authResult: User? = nil
    @Published var email = ""
    @Published var password = ""
    @Published var userName = ""
//    @Published var errorMessage: String?

    override init() {
        self.authResult = Auth.auth().currentUser
    }

    
    func validateData() -> Bool{
        
        if !self.isValidEmail(email: email){
            showAlert(message: "Please enter a valid email!")
            return false
        }
        
        if self.userName.isEmpty{
            showAlert(message: "Please enter a username")
            return false
        }
        
        if self.password.count < 8 {
            showAlert(message: "Password must be 8 characters long!")
            return false
        }
        
        return true
    }
    
    func signUp(completion: @escaping (Bool) -> Void) {
        
        if !validateData(){
            return
        }
        
        self.showLoader = true
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            DispatchQueue.main.async { [self] in
                if let error = error {
//                    self.errorMessage = error.localizedDescription
                    self.showAlert(message: error.localizedDescription)
                } else {
                    self.authResult = authResult?.user
                    self.setUserData(){ isFirstLogin in
                    
                        completion(true)
                        
                    }
                }
            }
            self.showLoader = false
        }
    }

    
    func setUserData(completion: @escaping (Bool) -> Void) {
        
        DatabaseManager.shared.getUserFrom(id: authResult?.uid ?? "", completion: { user in
        
            if user.isFirstLogin {
                
                let user = self.authResult
                var dbUser = UserModel()
                dbUser.id = user?.uid ?? ""
                dbUser.email = self.email
                dbUser.name = self.userName
                UserDefaultManager.shared.setID(id: user?.uid ?? "")
                DatabaseManager.shared.storeUserOnFirebase(user: dbUser)
                completion(true) //sending as a first Login
                
            } else {
                
                UserDefaultManager.shared.set(user: user)
                UserDefaultManager.Authenticated.send(true)
//                changeRootView(to: TabBar())
            }
            
        })
        

    }
    
    func login(completion: @escaping (Bool) -> Void) {
        self.showLoader = true
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.showAlert(message: error.localizedDescription)
                } else {
                    self.authResult = authResult?.user
                    self.setUserData(completion: {isFirstLogin in
                        
                    
                        if isFirstLogin{
                            
                            completion(true)
                            
                        }
                        
                        
                    })
                }
            }
            self.showLoader = false
        }
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.authResult = nil
            }
        } catch let error {
            self.showAlert(message: error.localizedDescription)
        }
    }
}
