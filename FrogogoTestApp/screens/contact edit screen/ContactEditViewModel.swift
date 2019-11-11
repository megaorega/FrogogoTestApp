// FrogogoTestApp
// Created on 10.11.2019
//
// Copyright © 2019 Oleg Mosyagin. All rights reserved.

import UIKit

class ContactEditViewModel: BaseViewModel {
    // MARK: - Properties
    let firstName:Box<String>   = Box(value: "")
    let lastName:Box<String>    = Box(value: "")
    let email:Box<String>       = Box(value: "")
    
    let showFirstNameAsInvalid:Box<Bool> = Box(value: false)
    let showLastNameAsInvalid:Box<Bool>  = Box(value: false)
    let showEmailAsInvalid:Box<Bool>     = Box(value: false)
    let saveButtonShouldBeEnabled:Box<Bool> = Box(value: false)
    
    private var currentModel:ContactModel!
    private var enteredFirstName:String = ""
    private var enteredLastName:String  = ""
    private var enteredEmail:String     = ""
    
    private var hasDataChangedOnce = false
    
    
    
    // MARK: - Overridden methods
    override func handlePassedObject(value: Any?) {
        super.handlePassedObject(value: value)
        
        guard let passedContactModel = value as! ContactModel? else { return }
        currentModel = passedContactModel
        setContactModelDataToDisplay()
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
        // TODO: need to call real DataManager to save data
        print("Need to save entered data")
        print("\t\(enteredFirstName)")
        print("\t\(enteredLastName)")
        print("\t\(enteredEmail)")
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
}
