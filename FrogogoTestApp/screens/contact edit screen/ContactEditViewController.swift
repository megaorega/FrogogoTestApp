// FrogogoTestApp
// Created on 09.11.2019
//
// Copyright © 2019 Oleg Mosyagin. All rights reserved.

import UIKit

class ContactEditViewController: BaseViewController {
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
    
    
    
    // MARK: - IBActions and handlers
    @IBAction func handleSaveBtnTap() {
        // TODO: need to call trigger method in viewModel
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelBtnTap() {
        self.dismiss(animated: true, completion: nil)
    }
}
