// FrogogoTestApp
// Created on 10.11.2019
//
// Copyright © 2019 Oleg Mosyagin. All rights reserved.

import Foundation

class ContactModel: BaseDataModel {
    // MARK: - Properties
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
    
}
