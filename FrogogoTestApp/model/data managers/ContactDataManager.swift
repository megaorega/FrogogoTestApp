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
                
                self.post(notification: .contactListFetchingOK, withPayload: self.contactList)
                
            } else {
                print("\(type(of: self)): Contact list receive failed!\n\(response!)")
                // TODO: need to handle error properly
                self.post(notification: .contactListFetchingFail)
            }
        }
    }
    
    func createContactWith(firstName:String, lastName:String, andEmail email:String) {
        let userDataDict = ["first_name": firstName,
                            "last_name" : lastName,
                            "email"     : email,
                            "avatar_url": ""]
        let params       = ["user": userDataDict]
        
        APIConnector.shared.requestPOST("users.json", params: params) { (isOK, response) in
            if (isOK) {
                print("\(type(of: self)): User created!")
                print(response!)
                
                let createdContact = ContactModel(withJSON: response!)
                
                self.contactList.insert(createdContact, at: 0)
                
                self.post(notification: .contactCreationOK, withPayload: createdContact)
                self.post(notification: .contactListFetchingOK, withPayload: self.contactList)
                
            } else {
                print("\(type(of: self)): User creation failed! Error: \(response!)")
                // TODO: need to handle error properly
                self.post(notification: .contactCreationFail)
            }
        }
    }
    
    func save(newFirstName:String, newLastName:String, andNewEmail newEmail:String, forContact editedContact:ContactModel) {
        print("Saving contact data")
        editedContact.firstName = newFirstName
        editedContact.lastName  = newLastName
        editedContact.email     = newEmail
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {[unowned self] in
            self.post(notification: .contactEditSaveOK, withPayload: editedContact)
        }
    }
}
