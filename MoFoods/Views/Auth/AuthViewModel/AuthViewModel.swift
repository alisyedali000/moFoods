//
//  AuthViewModel.swift
//  MoFoods
//
//  Created by Syed Ahmad  on 04/02/2025.
//

import SwiftUI
import FirebaseAuth

class AuthViewModel: ViewModel {
    @Published var user: User? = nil
    @Published var email = ""
    @Published var password = ""
    @Published var userName = ""
//    @Published var errorMessage: String?

    override init() {
        self.user = Auth.auth().currentUser
    }

    func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            DispatchQueue.main.async {
                if let error = error {
//                    self.errorMessage = error.localizedDescription
                    self.showAlert(message: error.localizedDescription)
                } else {
                    self.user = authResult?.user
                    DatabaseManager.shared.storeUserOnFirebase(user: FUser(id: self.user?.uid ?? "", name: self.userName, email: self.email))
                    self.showAlert(message: ("SignedUp as : \(self.user?.displayName ?? "")"))
                }
            }
        }
    }

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.showAlert(message: error.localizedDescription)
                } else {
                    self.user = authResult?.user
                    self.showAlert(message: ("Signed In as : \(self.user?.displayName ?? "")"))
                }
            }
        }
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.user = nil
            }
        } catch let error {
            self.showAlert(message: error.localizedDescription)
        }
    }
}
