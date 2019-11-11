// FrogogoTestApp
// Created on 09.11.2019
//
// Copyright © 2019 Oleg Mosyagin. All rights reserved.

import UIKit

class ContactEditViewController: BaseViewController, UITextFieldDelegate {
    // MARK: - Properties
    @IBOutlet var firstNameField:UITextField!
    @IBOutlet var firstNameFieldHint:UILabel!
    @IBOutlet var lastNameField:UITextField!
    @IBOutlet var lastNameFieldHint:UILabel!
    @IBOutlet var emailField:UITextField!
    @IBOutlet var emailFieldHint:UILabel!
    @IBOutlet var saveButton:UIButton!
    
    private let viewModel = ContactEditViewModel()
    
    
    
    // MARK: - Overridden methods
    override func createViewModel() {
        commonTypeViewModel = viewModel
    }
    
    override func addBindings() {
        super.addBindings()
        
        viewModel.firstName.bind { [unowned self] firstNameString in
            self.firstNameField.text = firstNameString
        }
        viewModel.showFirstNameAsInvalid.bind {[unowned self] needToShowAsInvalid in
            self.markTextFor(textField:     self.firstNameField,
                             useSwitchHint: self.firstNameFieldHint,
                             asInvalid:     needToShowAsInvalid)
        }
        
        viewModel.lastName.bind { [unowned self] lastNameString in
            self.lastNameField.text = lastNameString
        }
        viewModel.showLastNameAsInvalid.bind {[unowned self] needToShowAsInvalid in
            self.markTextFor(textField:     self.lastNameField,
                             useSwitchHint: self.lastNameFieldHint,
                             asInvalid:     needToShowAsInvalid)
        }
        
        viewModel.email.bind { [unowned self] emailString in
            self.emailField.text = emailString
        }
        viewModel.showEmailAsInvalid.bind {[unowned self] needToShowAsInvalid in
            self.markTextFor(textField:     self.emailField,
                             useSwitchHint: self.emailFieldHint,
                             asInvalid:     needToShowAsInvalid)
        }
        
        viewModel.saveButtonShouldBeEnabled.bind {[unowned self] needToEnable in
            self.saveButton.isEnabled = needToEnable
        }
    }
    
    
    
    // MARK: - Custom private methods
    private func handleTextChangeOf(_ textField:UITextField) {
        if (textField == firstNameField) {
            viewModel.updateEnteredFirstName(with: textField.text)
        } else if (textField == lastNameField) {
            viewModel.updateEnteredLastName(with: textField.text)
        } else if (textField == emailField) {
            viewModel.updateEnteredEmail(with: textField.text)
        }
    }
    
    private func markTextFor(textField:UITextField, useSwitchHint hintLabel:UILabel, asInvalid needToShowAsInvalid:Bool) {
        
        if (needToShowAsInvalid) {
            if (!textField.isFirstResponder) {
                hintLabel.isHidden = false
                textField.shakeAsInvalid()
            }
            
        } else {
            hintLabel.isHidden = true
        }
    }
    
    
    
    // MARK: - Textfield delegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == firstNameField) {
            lastNameField.becomeFirstResponder()
        } else if (textField == lastNameField) {
            emailField.becomeFirstResponder()
        } else if (textField == emailField) {
            viewModel.triggerSaveAttempt()
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        handleTextChangeOf(textField)
    }
    
    
    
    // MARK: - IBActions and handlers
    @IBAction func handleTextChange(in textField:UITextField) {
        handleTextChangeOf(textField)
    }
    
    @IBAction func handleSaveBtnTap() {
        viewModel.triggerSaveAttempt()
    }
    
    @IBAction func handleCancelBtnTap() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleEmptySpaceTap() {
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        emailField.resignFirstResponder()
    }
}
