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
        self.showLoader = true
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            DispatchQueue.main.async { [self] in
                if let error = error {
//                    self.errorMessage = error.localizedDescription
                    self.showAlert(message: error.localizedDescription)
                } else {
                    self.user = authResult?.user
                    var dbUser = UserModel()
                    dbUser.id = user?.uid ?? ""
                    dbUser.email = user?.email ?? ""
                    dbUser.name = self.userName
                    UserDefaultManager.shared.setID(id: user?.uid ?? "")
                    DatabaseManager.shared.storeUserOnFirebase(user: dbUser)
                    self.showAlert(message: ("SignedUp as : \(self.user?.displayName ?? "")"))
                }
            }
            self.showLoader = false
        }
    }

    func login() {
        self.showLoader = true
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.showAlert(message: error.localizedDescription)
                } else {
                    self.user = authResult?.user
                    UserDefaultManager.shared.setID(id: authResult?.user.uid ?? "")
//                    UserDefaultManager.Authenticated.send(true)
                    self.showAlert(message: ("Signed In as : \(self.user?.displayName ?? "")"))
                }
            }
            self.showLoader = false
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
