// FrogogoTestApp
// Created on 10.11.2019
//
// Copyright © 2019 Oleg Mosyagin. All rights reserved.

import Foundation

class ContactEditViewModel: BaseViewModel {
    enum ProcessingState:Int {
        case noActivity
        case inProgress
        case success
        case error
    }
    
    // MARK: - Properties
    let screenTitle:Box<String> = Box(value: "")
    
    let firstName:Box<String>   = Box(value: "")
    let lastName:Box<String>    = Box(value: "")
    let email:Box<String>       = Box(value: "")
    
    let showFirstNameAsInvalid:Box<Bool> = Box(value: false)
    let showLastNameAsInvalid:Box<Bool>  = Box(value: false)
    let showEmailAsInvalid:Box<Bool>     = Box(value: false)
    let saveButtonShouldBeEnabled:Box<Bool> = Box(value: false)
    let processingState:Box<ProcessingState> = Box(value: .noActivity)
    let processingMessage:Box<String> = Box(value: "")
    
    private var currentModel:ContactModel!
    private var enteredFirstName:String = ""
    private var enteredLastName:String  = ""
    private var enteredEmail:String     = ""
    
    private var hasDataChangedOnce = false
    
    
    
    // MARK: - Overridden methods
    override func handlePassedObject(value: Any?) {
        super.handlePassedObject(value: value)
        
        if let passedContactModel = value as! ContactModel? {
            currentModel = passedContactModel
            setContactModelDataToDisplay()
            screenTitle.value = NSLocalizedString("Edit contact", comment:"Edit contact screen title")
            
        } else {
            screenTitle.value = NSLocalizedString("Add contact", comment:"Contact creation screen title")
        }
    }
    
    override func subscribeForNotifications() {
        super.subscribeForNotifications()
        
        subscribeFor(notification: .contactCreationOK, onComplete: #selector(handleNotifContactCreationOK))
        subscribeFor(notification: .contactCreationFail, onComplete: #selector(handleNotifContactCreationFail))
        subscribeFor(notification: .contactEditSaveOK, onComplete: #selector(handleNotifContactEditOK))
        subscribeFor(notification: .contactEditSaveFail, onComplete: #selector(handleNotifContactEditFail))
    }
    
    
    
    // MARK: - Custom open/public/internal methods
    internal func updateEnteredFirstName(with enteredString:String?) {
        if (enteredFirstName != enteredString) {
            hasDataChangedOnce = true
        }
        
        guard let updatedFirstName = enteredString else {
            enteredFirstName = ""
            showFirstNameAsInvalid.value = true
            return
        }
        enteredFirstName = updatedFirstName
        showFirstNameAsInvalid.value = !enteredFirstName.isValidFirstName
        updateSaveButtonAvailability()
    }
    
    internal func updateEnteredLastName(with enteredString:String?) {
        if (enteredLastName != enteredString) {
            hasDataChangedOnce = true
        }
        
        guard let updatedLastName = enteredString else {
            enteredLastName = ""
            showLastNameAsInvalid.value = true
            return
        }
        enteredLastName = updatedLastName
        showLastNameAsInvalid.value = !enteredLastName.isValidLastName
        updateSaveButtonAvailability()
    }
    
    internal func updateEnteredEmail(with enteredString:String?) {
        if (enteredEmail != enteredString) {
            hasDataChangedOnce = true
        }
        
        guard let updatedEmail = enteredString else {
            enteredEmail = ""
            showEmailAsInvalid.value = true
            return
        }
        enteredEmail = updatedEmail
        showEmailAsInvalid.value = !enteredEmail.isValidEmail
        updateSaveButtonAvailability()
    }
    
    internal func triggerSaveAttempt() {
        processingState.value = .inProgress
        
        if (currentModel != nil) {
            ContactDataManager.shared.save(newFirstName: enteredFirstName,
                                            newLastName: enteredLastName,
                                            andNewEmail: enteredEmail,
                                             forContact: currentModel)
        } else {
            ContactDataManager.shared.createContactWith(firstName: enteredFirstName,
                                                         lastName: enteredLastName,
                                                         andEmail: enteredEmail)
        }
    }
    
    
    
    // MARK: - Custom private methods
    private func setContactModelDataToDisplay() {
        enteredFirstName = currentModel.firstName
        firstName.value  = currentModel.firstName
        
        enteredLastName = currentModel.lastName
        lastName.value  = currentModel.lastName

        enteredEmail = currentModel.email
        email.value  = currentModel.email
        
        updateSaveButtonAvailability()
    }
    
    private func updateSaveButtonAvailability() {
        saveButtonShouldBeEnabled.value = hasDataChangedOnce &&
                                          enteredFirstName.isValidFirstName &&
                                          enteredLastName.isValidLastName &&
                                          enteredEmail.isValidEmail
    }
    
    private func resetProcessingState(after delay:DispatchTimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {[unowned self] in
            self.processingState.value = .noActivity
            self.updateSaveButtonAvailability()
        }
    }
    
    
    
    // MARK: - Notification handlers
    @objc func handleNotifContactCreationOK() {
        processingMessage.value = NSLocalizedString("New contact was created", comment:"New contact creation success message")
        processingState.value = .success
    }
    
    @objc func handleNotifContactCreationFail(_ notif:Notification) {
        // TODO: need to show real error message
        processingMessage.value = NSLocalizedString("Failed to create contact", comment:"New contact creation fail message")
        processingState.value = .error
        resetProcessingState(after: .seconds(3))
    }
    
    @objc func handleNotifContactEditOK() {
        processingMessage.value = NSLocalizedString("Changes was saved", comment:"Contact edit success message")
        processingState.value = .success
    }
    
    @objc func handleNotifContactEditFail(_ notif:Notification) {
        // TODO: need to show real error message
        processingMessage.value = NSLocalizedString("Failed to save changes", comment:"Contact edit fail message")
        processingState.value = .error
        resetProcessingState(after: .seconds(3))
    }
}
