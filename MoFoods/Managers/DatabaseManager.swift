////
////  DatabaseManager.swift
////  MoFoods
////
////  Created by Syed Ahmad  on 04/02/2025.
////
//
//import Foundation
//import FirebaseDatabase
//
//class DatabaseManager {
//    
//    static let shared = DatabaseManager()
//    
//    let database = Database.database().reference()
//    
//    /// making firebase tabels keys
//    let users = "Users"
//
//
//}
//
//// MARK: Store user
//extension DatabaseManager {
//    
//    func storeUserOnFirebase(user: UserModel) {
//        
//        let firebaseID = "\(user.id)"
//        
//        let userData = UserModel().changeUserToDictionary(user: user, firebaseId: firebaseID)
//        
//        let reference = self.database.child(users).child(firebaseID)
//        
//        reference.setValue(userData)
//    }
//    
////    func updatePhoneNumber(number: String) {
////        
//////        let myFirebaseId = UserDefaultManager.shared.firebaseID
////        
////        if myFirebaseId.isEmpty {
////            debugPrint("firebase id is empty in update phone number")
////            return
////        }
////        
////        let reference = self.database.child("Users").child(myFirebaseId)
////        
////        reference.child("phone_number").setValue(number)
////    }
//    
////    func changeUserImage(image: String) {
////        
////        let myId = UserDefaultManager.shared.firebaseID
////        
////        if myId.isEmpty {
////            debugPrint("my firebase id is empty in change user name")
////            return
////        }
////        
////        self.database.child(users).child(myId).child("user_image").setValue(image)
////    }
//    
//    func updateUserPreferences(preferences: Preferences) {
//        
//        let pref = Preferences().changePreferencesToDictionary(preferences: preferences)
//        
//        let myId = UserDefaultManager.shared.userId
//        
//        if myId.isEmpty {
//            debugPrint("my firebase id is empty in change user name")
//            return
//        }
//        
//        self.database.child(users).child(myId).child("preferences").setValue(pref)
//        
//        self.database.child(users).child(myId).child("isFirstLogin").setValue(false)
//        
//    }
//    
//    func updateUserLocation(lat: Double, long: Double) {
//        
//        let locationData : [String : Any] =
//            
//            [
//                "lat": lat,
//                "long": long
//            ]
//        
//        
//        
//        let myId = UserDefaultManager.shared.userId
//        
//        if myId.isEmpty {
//            debugPrint("my firebase id is empty in change user name")
//            return
//        }
//        
//        self.database.child(users).child(myId).child("location").setValue(locationData)
//    }
//
//    
//    func getUserFrom(id: String, completion: @escaping (UserModel) -> Void) {
//        
//        if id.isEmpty {
//            
//            debugPrint("firebase id is empty get user")
//            return
//        }
//        
//        let reference = self.database.child(users)
//        
//        reference.child(id).observe(.value) { snapshot in
//            
//            if snapshot.exists() {
//             
//                do {
//                    
//                    let user = try snapshot.data(as: UserModel.self)
//                    
//                    completion(user)
//                    
//                } catch let error {
//                    debugPrint(error)
//                    completion(UserModel())
//                }
//                
//            } else {
//                
//                completion(UserModel())
//            }
//        }
//    }
//}


import Foundation
import FirebaseFirestore

class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    let database = Firestore.firestore()
    
    let users = "Users"
}

// MARK: Store user
extension DatabaseManager {
    
    func storeUserOnFirebase(user: UserModel) {
        let firebaseID = "\(user.id)"
        let userData = UserModel().changeUserToDictionary(user: user, firebaseId: firebaseID)
        
        let reference = database.collection(users).document(firebaseID)
        reference.setData(userData)
    }
    
    func updateUserPreferences(preferences: Preferences) {
        let pref = Preferences().changePreferencesToDictionary(preferences: preferences)
        let myId = UserDefaultManager.shared.userId
        
        if myId.isEmpty {
            debugPrint("firebase id is empty in update user preferences")
            return
        }
        
        let reference = database.collection(users).document(myId)
        reference.updateData([
            "preferences": pref,
            "isFirstLogin": false
        ])
    }
    
    func updateUserLocation(lat: Double, long: Double) {
        let locationData: [String: Any] = [
            "lat": lat,
            "long": long
        ]
        
        let myId = UserDefaultManager.shared.userId
        
        if myId.isEmpty {
            debugPrint("firebase id is empty in update user location")
            return
        }
        
        let reference = database.collection(users).document(myId)
        reference.updateData(["location": locationData])
    }
    
    func getUserFrom(id: String, completion: @escaping (UserModel) -> Void) {
        if id.isEmpty {
            debugPrint("firebase id is empty in get user")
            return
        }
        
        let reference = database.collection(users).document(id)
        reference.getDocument { snapshot, error in
            if let document = snapshot, document.exists {
                do {
                    let user = try document.data(as: UserModel.self)
                    completion(user)
                } catch {
                    debugPrint(error)
                    completion(UserModel())
                }
            } else {
                completion(UserModel())
            }
        }
    }
}
