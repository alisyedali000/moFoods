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
    @Published var showLoader = false
    
    func restorePreviousSignIn(completion: @escaping (Bool, Bool) -> Void) {
        GIDSignIn.sharedInstance.restorePreviousSignIn { [weak self] user, error in
            if let user = user {
                self?.authenticateUser(user: user) { result in
                    self?.authResult = result
                    self?.setUserData(completion: { isFirstLogin in
                        if isFirstLogin{
                            completion(true, true)
                        } else {
                            completion(true, false)
                        }
                    })
                }
   // Sign-in restored successfully
            } else {
                completion(false, false) // No previous sign-in, proceed with new login
            }
        }
    }

    func signIn(completion: @escaping (Bool) -> Void) {
        self.showLoader = true
        restorePreviousSignIn { [weak self] success, isFirstLogin in
            guard let self = self else { return }
            
            if success {
                print("User is already signed in. No need to re-authenticate.")
                if isFirstLogin{
                    completion(true)
                }
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
                    self.setUserData(){ isFirstLogin in
                        completion(isFirstLogin)
                    }
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
    
    private func setUserData(completion: @escaping (Bool) -> Void){
//        var user = UserModel()
//        user.email = authResult?.user.email ?? ""
//        user.name = authResult?.user.displayName ?? ""
//        user.id = authResult?.user.uid ?? ""
//        UserDefaultManager.shared.setID(id: authResult?.user.uid ?? "")
//        DatabaseManager.shared.storeUserOnFirebase(user: user)
        
        let authResultUser = authResult?.user
        
        DatabaseManager.shared.getUserFrom(id: authResultUser?.uid ?? "", completion: { user in
        
            if user.isFirstLogin {
                

                var dbUser = UserModel()
                dbUser.id = authResultUser?.uid ?? ""
                dbUser.email = authResultUser?.email ?? ""
                dbUser.name = authResultUser?.displayName ?? ""
                UserDefaultManager.shared.setID(id: authResultUser?.uid ?? "")
                DatabaseManager.shared.storeUserOnFirebase(user: dbUser)
                completion(true)

                
            } else {
                completion(false)
                UserDefaultManager.shared.set(user: user)
                UserDefaultManager.Authenticated.send(true)
//                changeRootView(to: TabBar())
                
            }
            
        })
        
        self.showLoader = false
        
        
    }

    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        try? Auth.auth().signOut()
        authResult = nil
    }
}
