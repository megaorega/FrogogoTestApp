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
        print("Making fake contacts")
        // TODO: need to send real request
        let fakeContacts = generateFakeContacts()
        // TODO: need to remove fake delay below
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {[unowned self] in
            self.post(notification: .contactListFetchingOK, withPayload: fakeContacts)
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
    
    
    
    // MARK: - Custom private methods
    // TODO: need to remove function below
    private func generateFakeContacts() -> [ContactModel] {
        var fakeContactList:[ContactModel] = []
        
        for i in 1...10 {
            let newContact = ContactModel()
            newContact.firstName    = "Константин"
            newContact.lastName     = "Константинопольский"
            newContact.email        = "emailemergentumenenen@gmail.com (\(i))"
            newContact.avatarURL    = "https://avatars1.githubusercontent.com/u/5061990?s=200&v=4"
            fakeContactList.append(newContact)
        }
        
        return fakeContactList
    }
}
