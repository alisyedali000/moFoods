//
//  FirebaseUser.swift
//  MoFoods
//
//  Created by Syed Ahmad  on 04/02/2025.
//

struct UserModel: Codable{
    
    var id: String
    var name, email : String
    var hasAdvancedSearch : Bool
    var hasPlusPlan, hasUnlimitedFavouritesMeal, hasUnlimitedGroups, hasUnlimitedPins, hasUnlimitedSharedFolders: Bool
    var pinCount, groupCount, sharedFolders: Int
    var preferences : Preferences?
    var location : Location?
    var isFirstLogin: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "firebaseID"
        case name, email
        case hasAdvancedSearch, hasPlusPlan, hasUnlimitedFavouritesMeal, hasUnlimitedGroups, hasUnlimitedPins, hasUnlimitedSharedFolders
        case pinCount, groupCount, sharedFolders
        case preferences
        case location
        case isFirstLogin
       
    }

    
    init(){
        self.id = ""
        self.name = ""
        self.email = ""
        self.hasPlusPlan = false
        self.hasAdvancedSearch = false
        self.hasUnlimitedFavouritesMeal = false
        self.hasUnlimitedGroups = false
        self.hasUnlimitedPins = false
        self.hasUnlimitedSharedFolders = false
        self.pinCount = 0
        self.groupCount = 0
        self.sharedFolders = 0
        self.preferences = Preferences()
        self.location = Location()
        self.isFirstLogin = true

    }

    
}

extension UserModel{
    
    func changeUserToDictionary(user: UserModel, firebaseId: String) -> [String : Any] {
        
        let userValue : [String : Any] = [
            "name": user.name,
            "email": user.email,
            "firebaseID": firebaseId,
            "groupCount": user.groupCount,
            "hasAdvancedSearch": user.hasAdvancedSearch,
            "hasPlusPlan": user.hasPlusPlan,
            "hasUnlimitedFavouritesMeal" : user.hasUnlimitedFavouritesMeal,
            "hasUnlimitedGroups": user.hasUnlimitedGroups,
            "hasUnlimitedPins": user.hasUnlimitedPins,
            "hasUnlimitedSharedFolders": user.hasUnlimitedSharedFolders,
            "pinCount": user.pinCount,
            "sharedFolders" : user.sharedFolders,
            "isFirstLogin" : user.isFirstLogin
        ]
        
        return userValue
    }
    
}

struct Preferences: Codable, Hashable{
    
    var ambiance, prefferedCuisine, allergies : [String]
    var distance : Double
    enum CodingKeys: String, CodingKey {
        case ambiance, prefferedCuisine, allergies
        case distance
    }
    
    init(ambiance: [String], prefferedCuisine: [String], allergies: [String], distance: Double) {
        self.ambiance = ambiance
        self.prefferedCuisine = prefferedCuisine
        self.allergies = allergies
        self.distance = distance
    }
    
    init(){
        self.ambiance = []
        self.prefferedCuisine = []
        self.allergies = []
        self.distance = 0.0
    }
    
    func changePreferencesToDictionary(preferences: Preferences) -> [String : Any] {
        
        let prefValues : [String : Any] = [

             
                 "ambiance": preferences.ambiance,
                 "prefferedCuisine": preferences.prefferedCuisine,
                 "allergies": preferences.allergies,
                 "distance" : preferences.distance
        ]
        
        return prefValues
    }
}


struct Location: Codable{
    
    var lat, long: Double
    
    enum CodingKeys: String, CodingKey{
        
        case lat, long
        
    }
    
    init(lat: Double, long: Double) {
        self.lat = lat
        self.long = long
    }
    
    init(){
        self.lat = 0.0
        self.long = 0.0
    }
    
}
