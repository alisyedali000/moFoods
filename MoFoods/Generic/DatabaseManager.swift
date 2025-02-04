//
//  DatabaseManager.swift
//  MoFoods
//
//  Created by Syed Ahmad  on 04/02/2025.
//

import Foundation
import FirebaseDatabase

class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    let database = Database.database().reference()
    
    /// making firebase tabels keys
    let users = "Users"


}

// MARK: Store user
extension DatabaseManager {
    
    func storeUserOnFirebase(user: FUser) {
        
        let firebaseID = "_\(user.id)"
        
        let userData = FirebaseUser().changeUserToDictionary(user: user, firebaseId: firebaseID)
        
        let reference = self.database.child(users).child(firebaseID)
        
        reference.setValue(userData)
    }
    
//    func updatePhoneNumber(number: String) {
//        
////        let myFirebaseId = UserDefaultManager.shared.firebaseID
//        
//        if myFirebaseId.isEmpty {
//            debugPrint("firebase id is empty in update phone number")
//            return
//        }
//        
//        let reference = self.database.child("Users").child(myFirebaseId)
//        
//        reference.child("phone_number").setValue(number)
//    }
    
//    func changeUserImage(image: String) {
//        
//        let myId = UserDefaultManager.shared.firebaseID
//        
//        if myId.isEmpty {
//            debugPrint("my firebase id is empty in change user name")
//            return
//        }
//        
//        self.database.child(users).child(myId).child("user_image").setValue(image)
//    }
    
//    func changeUserName(name: String) {
//        
//        let myId = UserDefaultManager.shared.firebaseID
//        
//        if myId.isEmpty {
//            debugPrint("my firebase id is empty in change user name")
//            return
//        }
//        
//        self.database.child(users).child(myId).child("user_name").setValue(name)
//    }
    

    
    func getUserFrom(id: String, completion: @escaping (FirebaseUser) -> Void) {
        
        if id.isEmpty {
            
            debugPrint("firebase id is empty get user")
            return
        }
        
        let reference = self.database.child(users)
        
        reference.child(id).observe(.value) { snapshot in
            
            if snapshot.exists() {
             
                do {
                    
                    let user = try snapshot.data(as: FirebaseUser.self)
                    
                    completion(user)
                    
                } catch let error {
                    debugPrint(error)
                    completion(FirebaseUser())
                }
                
            } else {
                
                completion(FirebaseUser())
            }
        }
    }
}
