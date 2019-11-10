// FrogogoTestApp
// Created on 09.11.2019
//
// Copyright © 2019 Oleg Mosyagin. All rights reserved.

import UIKit

class ContactEditViewController: BaseViewController {
    // MARK: - Properties
    private let viewModel = ContactEditViewModel()
    
    
    
    // MARK: - Overridden methods
    override func createViewModel() {
        commonTypeViewModel = viewModel
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
