//
//  FirebaseUser.swift
//  MoFoods
//
//  Created by Syed Ahmad  on 04/02/2025.
//


struct FirebaseUser : Codable {
    
    var name: String
    var email: String
    var firebaseID: String

    
    enum CodingKeys: String, CodingKey {
        
        case name = "user_name"
        case email = "phone_number"
        case firebaseID = "firebaseID"

    }
}

extension FirebaseUser {
    
    init() {
        
        self.name = ""
        self.email = ""
        self.firebaseID = ""

    }
}

extension FirebaseUser {
    
    func changeUserToDictionary(user: FUser, firebaseId: String) -> [String : Any] {
        
        let userValue : [String : Any] = [
            "user_name": user.name,
            "email": user.email,
            "firebaseID": firebaseId
        ]
        
        return userValue
    }
}


struct FUser: Codable{
    let id: String
    let name, email : String

    enum CodingKeys: String, CodingKey {
        case id, name, email
       
    }
    init(id: String, name: String, email: String) {
        self.id = id
        self.name = name
        self.email = email
    }
    
}
