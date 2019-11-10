// FrogogoTestApp
// Created on 09.11.2019
//
// Copyright © 2019 Oleg Mosyagin. All rights reserved.

import UIKit

class ContactEditViewController: BaseViewController, UITextFieldDelegate {
    // MARK: - Properties
    @IBOutlet var firstNameField:UITextField!
    @IBOutlet var lastNameField:UITextField!
    @IBOutlet var emailField:UITextField!
    
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
        viewModel.lastName.bind { [unowned self] lastNameString in
            self.lastNameField.text = lastNameString
        }
        viewModel.email.bind { [unowned self] emailString in
            self.emailField.text = emailString
        }
    }
    
    
    
    // MARK: - Textfield delegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == firstNameField) {
            lastNameField.becomeFirstResponder()
        } else if (textField == lastNameField) {
            emailField.becomeFirstResponder()
        } else if (textField == emailField) {
            handleSaveAttempt()
        }
        
        return true
    }
    
    
    
    // MARK: - Custom private methods
    private func handleSaveAttempt() {
        // TODO: need to call trigger method in viewModel
        print("Trying to save contact edit")
    }
    
    
    
    // MARK: - IBActions and handlers
    @IBAction func handleSaveBtnTap() {
        handleSaveAttempt()
    }
    
    @IBAction func cancelBtnTap() {
        self.dismiss(animated: true, completion: nil)
    }
}
