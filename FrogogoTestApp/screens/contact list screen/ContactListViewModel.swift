// FrogogoTestApp
// Created on 10.11.2019
//
// Copyright © 2019 Oleg Mosyagin. All rights reserved.

import UIKit

class ContactListViewModel: BaseViewModel {
    // MARK: - Properties
    let contactList:Box<[ContactModel]> = Box(value: [])
    
    
    
    // MARK: - Overridden methods
    override func viewWillAppearTrigger() {
        super.viewWillAppearTrigger()
        
        fakeFetchOfContacts()
    }
    
    
    
    // MARK: - Custom private methods
    private func fakeFetchOfContacts() {
        var fakeContactList:[ContactModel] = []
        
        for i in 1...10 {
            let newContact = ContactModel()
            newContact.firstName    = "Константин"
            newContact.lastName     = "Кон"
            newContact.email        = "emailemergentumenenen@gmail.com (\(i))"
            newContact.avatarURL    = "https://avatars1.githubusercontent.com/u/5061990?s=200&v=4"
            fakeContactList.append(newContact)
        }
        
        contactList.value = fakeContactList
    }
}
