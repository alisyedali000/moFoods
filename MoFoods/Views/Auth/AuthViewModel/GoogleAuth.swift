//
//  GoogleAuth.swift
//  MoFoods
//
//  Created by Syed Ahmad  on 04/02/2025.
//
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

class GoogleSignIn: ObservableObject {
    
    @Published var authResult: AuthDataResult?

    func restorePreviousSignIn(completion: @escaping (Bool) -> Void) {
        GIDSignIn.sharedInstance.restorePreviousSignIn { [weak self] user, error in
            if let user = user {
                self?.authenticateUser(user: user) { result in
                    self?.authResult = result
                    
                }
                completion(true)  // Sign-in restored successfully
            } else {
                completion(false) // No previous sign-in, proceed with new login
            }
        }
    }

    func signIn() {
        restorePreviousSignIn { [weak self] success in
            guard let self = self else { return }
            
            if success {
                print("User is already signed in. No need to re-authenticate.")
                return
            }
            
            // If no previous sign-in, proceed with new login
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
            let config = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.configuration = config

            guard let presentingViewController = UIApplication.shared.windows.first?.rootViewController else { return }

            GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { signInResult, error in
                if let error = error {
                    print("Google Sign-In failed: \(error.localizedDescription)")
                    return
                }

                guard let signInResult = signInResult else { return }
                self.authenticateUser(user: signInResult.user) { result in
                    self.authResult = result
                    self.setUserData()
                }
            }
        }
    }

    private func authenticateUser(user: GIDGoogleUser, completion: @escaping (AuthDataResult?) -> Void) {
        let idToken = user.idToken?.tokenString
        let accessToken = user.accessToken.tokenString
        let credential = GoogleAuthProvider.credential(withIDToken: idToken ?? "", accessToken: accessToken)

        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print("Firebase authentication failed: \(error.localizedDescription)")
                completion(nil)
            } else {
                print("User signed in with Firebase: \(authResult?.user.uid ?? "Unknown UID")")
                completion(authResult)
            }
        }
    }
    
    private func setUserData(){
        var user = UserModel()
        user.email = authResult?.user.email ?? ""
        user.name = authResult?.user.displayName ?? ""
        user.id = authResult?.user.uid ?? ""
        UserDefaultManager.shared.setID(id: authResult?.user.uid ?? "")
        DatabaseManager.shared.storeUserOnFirebase(user: user)
    }

    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        try? Auth.auth().signOut()
        authResult = nil
    }
}
