//
//  GoogleAuth.swift
//  MoFoods
//
//  Created by Syed Ahmad  on 04/02/2025.
//


//import Firebase
//import GoogleSignIn
//import SwiftUI
//
//class GoogleAuth: ObservableObject {
//
//}
//extension GoogleAuth{
//    func signIn(completion: @escaping (AuthDataResult) -> Void) {
//        
//        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
//            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
//                self.authenticateUser(for: user, with: error, authData: { result in
//                    completion(result)
//                })
//            }
//        } else {
//            
//            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
//            
//            
//            let configuration = GIDConfiguration(clientID: clientID)
//            
//            
//            guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}
//            
//            
//            GIDSignIn.sharedInstance.signIn(with: configuration, presenting: presentingViewController) { user, error in
//                self.authenticateUser(for: user, with: error, authData: { result in
//                    completion(result)
//                })
//           
//            }
//        }
//    }
//    
//    private func authenticateUser(for user: GIDGoogleUser?, with error: Error?, authData : @escaping(AuthDataResult) -> Void) {
//        
//        if let error = error {
//            print(error.localizedDescription)
//            return
//        }
//        
//        
//        guard let authentication = user?.authentication, let idToken = authentication.idToken else { return }
//        
//        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
//        
//        
//        Auth.auth().signIn(with: credential) { authResult, error in
//            
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }else{
////                self.setUserData(authResult: authResult!)
//                authData(authResult!)
//            }
//            
//        }
//    }
//    
//    
//    func signOut() {
//        
//        GIDSignIn.sharedInstance.signOut()
//        
//        do {
//            
//            try Auth.auth().signOut()
//            
////            state = .signedOut
//            //        UserDefaultManager.Authenticated.send(false)
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//    
//    func deleteUser(){
//        let user = Auth.auth().currentUser
//        
//        user?.delete { error in
//            if let error = error {
//                print(error.localizedDescription)
//            } else {
//                print("User successfully deleted from firebase")
//            }
//        }
//        
//        
//    }
//    
//    
//    
////    func setUserData(authResult: AuthDataResult){
////
//////        self.authVM.email = authResult.user.email ?? ""
//////        self.authVM.name = authResult.user.displayName ?? ""
//////        self.authVM.socialKey = "google"
//////        self.authVM.socialToken = authResult.user.uid
//////        self.authVM.deviceID = ""
////        Task{
//////            await authVM.socialLogin(){
//////                UserDefaultManager.shared.setSocialLogin(true)
////            }
////        }
//        
//        
////    }
//        
//}
