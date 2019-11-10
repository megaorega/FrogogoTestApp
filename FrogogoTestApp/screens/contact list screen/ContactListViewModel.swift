// FrogogoTestApp
// Created on 10.11.2019
//
// Copyright © 2019 Oleg Mosyagin. All rights reserved.

import UIKit

class ContactListViewModel: BaseViewModel {
    // MARK: - Properties
    let contactList:Box<[ContactModel]> = Box(value: [])
    let refreshStatusString:Box<String> = Box(value: "")
    let segueIdentifierToPerform: Box<String?> = Box(value: nil)
    
    
    
    // MARK: - Overridden methods
    override func viewWillAppearTrigger() {
        super.viewWillAppearTrigger()
        
        fakeFetchOfContacts()
    }
    
    
    
    // MARK: - Custom open/public/internal methods
    internal func triggerContactsRefreshing() {
        refreshStatusString.value = "updating..."
        // TODO: need to call real data manager for contact refreshing
        fakeFetchOfContacts()
    }
    
    internal func triggerAddContact() {
        segueIdentifierToPerform.value = "segueFromContactListToEditContact"
    }
    
    internal func triggerEditContact(_ contactModel:ContactModel) {
        passingObject = contactModel
        print("Need to open edit for contact \(contactModel.fullName)")
        // TODO: need to open edit contact screen with segue
        // TODO: возможно здесь нужно будет занулить passingObject, чтобы при открывании экрана создания не передавалась модель
    }
    
    
    
    // MARK: - Custom private methods
    private func fakeFetchOfContacts() {
        var fakeContactList:[ContactModel] = []
        
        for i in 1...10 {
            let newContact = ContactModel()
            newContact.firstName    = "Константин"
            newContact.lastName     = "Константинопольский"
            newContact.email        = "emailemergentumenenen@gmail.com (\(i))"
            newContact.avatarURL    = "https://avatars1.githubusercontent.com/u/5061990?s=200&v=4"
            fakeContactList.append(newContact)
        }
        
        // TODO: need to remove refresh status update below
        refreshStatusString.value = "updated now"
        contactList.value = fakeContactList
    }
}
