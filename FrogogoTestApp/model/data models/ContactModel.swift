// FrogogoTestApp
// Created on 10.11.2019
//
// Copyright © 2019 Oleg Mosyagin. All rights reserved.

import Foundation
import SwiftyJSON

class ContactModel: BaseDataModel {
    // MARK: - Properties
    var id          = ""
    var firstName   = ""
    var lastName    = ""
    var email       = ""
    var avatarURL   = ""
    
    // MARK: Computed properties
    var fullName:String {
        var nameToReturn = firstName
        
        // add space as separator, if firstName was not empty
        nameToReturn += nameToReturn.isEmpty ? lastName : " " + lastName
        
        return nameToReturn
    }
    
    
    
    // MARK: - Overridden methods
    override func update(withJSON jsonData: JSON) {
        super.update(withJSON: jsonData)
        
        id = jsonData["id"].stringValue
        
        firstName = jsonData["first_name"].stringValue
        lastName  = jsonData["last_name"].stringValue
        email     = jsonData["email"].stringValue
        avatarURL = jsonData["avatar_url"].stringValue
    }
}
