// FrogogoTestApp
// Created on 11.11.2019
//
// Copyright © 2019 Oleg Mosyagin. All rights reserved.

import Foundation

class ContactDataManager: BaseDataManager {
    // MARK: - Properties
    static let shared = ContactDataManager()
    
    private var contactList:[ContactModel] = []
    
    
    
    // MARK: - Custom open/public/internal methods
    func fetchContactList() {
        APIConnector.shared.requestGET("users.json") {[unowned self] (isOK, response) in
            
            if (isOK) {
                print("\(type(of: self)): Contact list received!")
                
                var parsedContacts:[ContactModel] = []
                for jsonData in response!.arrayValue {
                    parsedContacts.append(ContactModel(withJSON: jsonData))
                }
                
                self.contactList = parsedContacts
                self.sortContactsByUpdateDate()
                self.post(notification: .contactListFetchingOK, withPayload: self.contactList)
                self.post(notification: .contactListUpdated, withPayload: self.contactList)
                
            } else {
                print("\(type(of: self)): Contact list receive failed!\n\(response!)")
                // TODO: need to handle error properly
                self.post(notification: .contactListFetchingFail)
            }
        }
    }
    
    func createContactWith(firstName:String, lastName:String, andEmail email:String) {
        let randomAvatarURL = "https://i.pravatar.cc/180?u=" + UUID().uuidString
        
        let userDataDict = ["first_name": firstName,
                            "last_name" : lastName,
                            "email"     : email,
                            "avatar_url": randomAvatarURL]
        let params = ["user": userDataDict]
        
        APIConnector.shared.requestPOST("users.json", params: params) {[unowned self] (isOK, response) in
            if (isOK) {
                print("\(type(of: self)): User created!")
                
                let createdContact = ContactModel(withJSON: response!)
                self.contactList.insert(createdContact, at: 0)
                
                self.post(notification: .contactCreationOK, withPayload: createdContact)
                self.post(notification: .contactListUpdated, withPayload: self.contactList)
                
            } else {
                print("\(type(of: self)): User creation failed! Error: \(response!)")
                // TODO: need to handle error properly
                self.post(notification: .contactCreationFail)
            }
        }
    }
    
    func save(newFirstName:String, newLastName:String, andNewEmail newEmail:String, forContact editedContact:ContactModel) {
        
        let userDataDict = ["first_name": newFirstName,
                            "last_name" : newLastName,
                            "email"     : newEmail,
                            "avatar_url": editedContact.avatarURL]
        let params = ["user": userDataDict]
        
        let addressToPatch = "users/\(editedContact.id).json"
        
        APIConnector.shared.requestPATCH(addressToPatch, params: params) {[unowned self] (isOK, response) in
            if (isOK) {
                print("\(type(of: self)): User changes saved!")
                
                editedContact.update(withJSON: response!)
                self.sortContactsByUpdateDate()
                self.post(notification: .contactEditSaveOK, withPayload: editedContact)
                self.post(notification: .contactListUpdated, withPayload: self.contactList)
                
            } else {
                print("\(type(of: self)): User changes save failed! Error: \(response!)")
                // TODO: need to handle error properly
                self.post(notification: .contactEditSaveFail)
            }
        }
    }
    
    
    // MARK: - Custom private methods
    private func sortContactsByUpdateDate() {
        self.contactList.sort { (oneContact, otherContact) -> Bool in
            return oneContact.updated! > otherContact.updated!
        }
    }
}
