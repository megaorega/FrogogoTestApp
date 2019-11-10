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
    
    var currentModel:ContactModel!
    
    
    
    // MARK: - Overridden methods
    override func handlePassedObject(value: Any?) {
        super.handlePassedObject(value: value)
        
        guard let passedContactModel = value as! ContactModel? else { return }
        currentModel = passedContactModel
        setContactModelDataToDisplay()
    }
    
    
    
    // MARK: - Custom private methods
    private func setContactModelDataToDisplay() {
        firstName.value = currentModel.firstName
        lastName.value  = currentModel.lastName
        email.value     = currentModel.email
    }
}
