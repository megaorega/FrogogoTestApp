// FrogogoTestApp
// Created on 11.11.2019
//
// Copyright © 2019 Oleg Mosyagin. All rights reserved.

import Foundation

class ContactDataManager: BaseDataManager {
    // MARK: - Properties
    static let shared = ContactDataManager()
    
    
    
    // MARK: - Custom open/public/internal methods
    func fetchContactList() {
        APIConnector.shared.requestGET("users.json") {[unowned self] (isOK, response, error) in
            
            if (isOK) {
                print("\(type(of: self)): Contact list received!")
                var parsedContacts:[ContactModel] = []
                for jsonData in response!.arrayValue {
                    parsedContacts.append(ContactModel(withJSON: jsonData))
                }
                
                self.post(notification: .contactListFetchingOK, withPayload: parsedContacts)
                
            } else {
                print("\(type(of: self)): Contact list receive failed!\n\(error!)")
                // TODO: need to handle error properly
            }
        }
    }
    
    func createContactWith(firstName:String, lastName:String, andEmail email:String) {
        print("Creating contact:")
        print("\t" + firstName)
        print("\t" + lastName)
        print("\t" + email)
        let createdContact = ContactModel()
        createdContact.firstName = firstName
        createdContact.lastName  = lastName
        createdContact.email     = email
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {[unowned self] in
            self.post(notification: .contactCreationOK, withPayload: createdContact)
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
