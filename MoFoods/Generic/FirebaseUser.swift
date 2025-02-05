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

    enum CodingKeys: String, CodingKey {
        case id = "firebaseID"
        case name, email
        case hasAdvancedSearch, hasPlusPlan, hasUnlimitedFavouritesMeal, hasUnlimitedGroups, hasUnlimitedPins, hasUnlimitedSharedFolders
        case pinCount, groupCount, sharedFolders
        case preferences
       
    }
    init(id: String, name: String, email: String, hasAdvancedSearch: Bool, hasPlusPlan: Bool, hasUnlimitedFavouritesMeal: Bool, hasUnlimitedGroups: Bool, hasUnlimitedPins: Bool, hasUnlimitedSharedFolders: Bool, pinCount: Int, groupCount : Int, sharedFolders: Int, preferenes : Preferences) {
        self.id = id
        self.name = name
        self.email = email
        self.hasAdvancedSearch = hasAdvancedSearch
        self.hasPlusPlan = hasPlusPlan
        self.hasUnlimitedFavouritesMeal = hasUnlimitedFavouritesMeal
        self.hasUnlimitedGroups = hasUnlimitedGroups
        self.hasUnlimitedPins = hasUnlimitedPins
        self.hasUnlimitedSharedFolders = hasUnlimitedSharedFolders
        self.pinCount = pinCount
        self.groupCount = groupCount
        self.sharedFolders = sharedFolders
        self.preferences = preferenes
        
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
            "preferences": [
                "ambiance": user.preferences?.ambiance,
                "prefferedCuisine": user.preferences?.prefferedCuisine,
                "allergies": user.preferences?.allergies
             ]
        ]
        
        return userValue
    }
    
}

struct Preferences: Codable, Hashable{
    
    var ambiance, prefferedCuisine, allergies : [String]
    
    enum CodingKeys: String, CodingKey {
        case ambiance, prefferedCuisine, allergies
       
    }
    
    init(ambiance: [String], prefferedCuisine: [String], allergies: [String]) {
        self.ambiance = ambiance
        self.prefferedCuisine = prefferedCuisine
        self.allergies = allergies
    }
    
    init(){
        self.ambiance = []
        self.prefferedCuisine = []
        self.allergies = []
    }
    
    func changePreferencesToDictionary(preferences: Preferences) -> [String : Any] {
        
        let prefValues : [String : Any] = [

             
                 "ambiance": preferences.ambiance,
                 "prefferedCuisine": preferences.prefferedCuisine,
                 "allergies": preferences.allergies
             
        ]
        
        return prefValues
    }
}
