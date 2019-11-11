// FrogogoTestApp
// Created on 10.11.2019
//
// Copyright © 2019 Oleg Mosyagin. All rights reserved.

import Foundation

class ContactListViewModel: BaseViewModel {
    // MARK: - Properties
    let screenTitle:Box<String> = Box(value: "")
    
    let contactList:Box<[ContactModel]> = Box(value: [])
    let refreshStatusString:Box<String> = Box(value: "")
    let refreshingActive:Box<Bool>      = Box(value: false)
    let segueIdentifierToPerform: Box<String?> = Box(value: nil)
    
    
    
    // MARK: - Overridden methods
    override func viewWillAppearTrigger() {
        super.viewWillAppearTrigger()
        
        updateScreenTitle()
        triggerContactsRefreshing()
    }
    
    override func subscribeForNotifications() {
        super.subscribeForNotifications()
        
        subscribeFor(notification: .contactListUpdated, onComplete: #selector(handleNotifContactListUpdated))
        subscribeFor(notification: .contactListFetchingOK, onComplete: #selector(handleNotifContactListFetchingOK))
        subscribeFor(notification: .contactListFetchingFail, onComplete: #selector(handleNotifContactListFetchingFail))
    }
    
    
    
    // MARK: - Custom open/public/internal methods
    internal func triggerContactsRefreshing() {
        refreshStatusString.value = NSLocalizedString("updating...", comment: "Refresh control title at loading state")
        refreshingActive.value    = true
        ContactDataManager.shared.fetchContactList()
    }
    
    internal func triggerAddContact() {
        segueIdentifierToPerform.value = "segueFromContactListToEditContact"
    }
    
    internal func triggerEditContact(_ contactModel:ContactModel) {
        passingObject = contactModel
        segueIdentifierToPerform.value = "segueFromContactListToEditContact"
        passingObject = nil
    }
    
    
    
    // MARK: - Custom private methods
    private func updateScreenTitle() {
        var updatedScreenTitle = "Contacts"
        
        let contactListCount = contactList.value.count
        if (contactListCount > 0) {
            updatedScreenTitle += ": \(contactListCount)"
        }
        
        screenTitle.value = updatedScreenTitle
    }
    
    
    
    // MARK: - Notifications handling
    @objc func handleNotifContactListUpdated(_ notification:Notification) {
        let updatedContactList = notification.userInfo![BaseDataManager.notificationPayloadKey] as! [ContactModel]
        contactList.value = updatedContactList
        updateScreenTitle()
        
        // TODO: need to make a string with timestamp to show update time
        refreshStatusString.value = ""
        //refreshStatusString.value = NSLocalizedString("up to date", comment:"Refresh control title for updated state")
    }
    
    @objc func handleNotifContactListFetchingOK() {
        refreshingActive.value = false
    }
    
    @objc func handleNotifContactListFetchingFail(_ notification:Notification) {
        print("Need to show error of contact list fetching")
    }
}
