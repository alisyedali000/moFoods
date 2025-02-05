//
//  AppleSignIn.swift
//  MoFoods
//
//  Created by Syed Ahmad  on 04/02/2025.
//


import Foundation
import SwiftUI
import CryptoKit
import Firebase
import AuthenticationServices
import FirebaseAuth

class AppleSignIn: NSObject, ObservableObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    @Published var authResult : AuthDataResult?

    private var currentNonce: String?
    private var completionHandler: ((Bool) -> Void)?

    func signIn(completion: @escaping (Bool) -> Void) {
        currentNonce = randomNonceString()
        self.completionHandler = completion  // Store the completion handler

        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(currentNonce!)

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            print("Successfully signed out")
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {

            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }

            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                self.completionHandler?(false)  // Call the completion handler with failure
                return
            }

            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                self.completionHandler?(false)  // Call the completion handler with failure
                return
            }

            let fullName = appleIDCredential.fullName?.givenName
            let email = appleIDCredential.email
            let token = appleIDCredential.user
            let userIdentifier = appleIDCredential.user
            debugPrint("User id is \(token) \n Full Name is \(String(describing: fullName)) \n Email id is \(String(describing: email))")
            getCredentialState(userID: userIdentifier)

            /// Signing in with Firebase
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase sign-in error: \(error.localizedDescription)")
                    self.completionHandler?(false)  // Call the completion handler with failure
                } else {
                    
                    
                    authResult?.user.getIDTokenResult(completion: { (idTokenResult, error) in
                        if let error = error {
                            print("Error fetching ID Token Result: \(error.localizedDescription)")
                        } else if let idTokenResult = idTokenResult {
                            print("ID Token: \(idTokenResult.token)")
//                            UserDefaultManager.shared.setToken(idTokenResult.token)
                            print("Expiration Date: \(idTokenResult.expirationDate)")
                            print("Auth Time: \(idTokenResult.authDate)")
                            print("Issued At: \(idTokenResult.issuedAtDate)")
                            print("Sign-in Provider: \(idTokenResult.signInProvider)")
                            self.completionHandler?(true)
                        }
                    })
//                    authResult?.user
                    
                    print("Successfully signed in with Apple and Firebase.")
                    self.setUserData(authResult: authResult!)

                    debugPrint(authResult?.user.uid ?? "No UID")
                     // Call the completion handler with success
                }
            }
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Sign in with Apple error: \(error.localizedDescription)")
        self.completionHandler?(false)  // Call the completion handler with failure
    }

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.windows.first!
    }

    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        while result.count < length {
            let randomBytes: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            randomBytes.forEach {
                if result.count < length {
                    let value = $0
                    if value < charset.count {
                        result.append(charset[Int(value)])
                    }
                }
            }
        }
        return result
    }

    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        return hashString
    }
}

extension AppleSignIn {
    
    func setUserData(authResult: AuthDataResult) {
        self.authResult = authResult
        
        DatabaseManager.shared.getUserFrom(id: authResult.user.uid, completion: { user in
        
            if user.preferences?.allergies.isEmpty ?? true{
                
                let user = authResult.user
                var dbUser = UserModel()
                dbUser.id = user.uid
                dbUser.email = user.email ?? ""
                dbUser.name = user.displayName ?? ""
                UserDefaultManager.shared.setID(id: user.uid)
                DatabaseManager.shared.storeUserOnFirebase(user: dbUser)
                
            } else {
                
                UserDefaultManager.shared.set(user: user)
                UserDefaultManager.Authenticated.send(true)
                
            }
            
        })
        

    }

    func getCredentialState(userID: String) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: userID) { credentialState, _ in
            switch credentialState {
            case .authorized:
                break
            case .revoked:
                break
            case .notFound:
                break
            default:
                break
            }
        }
    }
}
