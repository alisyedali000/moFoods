//
//  UserType.swift
//  MoFoods
//
//  Created by Syed Ahmad  on 05/02/2025.
//


import Foundation
import Combine
import SwiftUI

enum UserDefaultEnum: String {
    case userType
    case socialLogin
    case userDetails
    case deviceId

}


class UserDefaultManager {
    
    static let shared = UserDefaultManager()
    let userDefaults : UserDefaults = UserDefaults.standard
    
    // this will return the empty stirng if no value is founded into UserDefaults.
    var userId: String {
        return UserDefaultManager.shared.getID()
    }


    static let Authenticated = PassthroughSubject<Bool, Never>()
    static let moveToProfile = PassthroughSubject<Bool, Never>()
    
    static func IsAuthenticated() -> Bool {
        //this means that userDefaults have some data
        if shared.get() != nil{
            return true
        }
        return false
    }
    
    /// save user object into userDefaults
    func set(user: UserModel?) {
        if let User = user{
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(User) {
                userDefaults.set(encoded, forKey: UserDefaultEnum.userDetails.rawValue)
            }
        }
    }

    func get() -> UserModel? {
   
        if let userData: Data =  userDefaults.object(forKey: UserDefaultEnum.userDetails.rawValue) as? Data {
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(UserModel.self, from: userData) {
                return user
            }
            print("User Decoder Error")
        }
        print("User Not Found in UsersDefaults")
        return nil
    }
    
    func removeUser() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        UserDefaultManager.Authenticated.send(false)
    }
    

    func setID(id:String){
        userDefaults.set(id, forKey: "ID")
    }
    func getID() -> String{
        userDefaults.string(forKey: "ID") ?? ""
    }
    
    var userName: String {
        return UserDefaultManager.shared.get()?.name ?? ""
    }
}


