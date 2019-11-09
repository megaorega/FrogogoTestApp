// FrogogoTestApp
// Created on 09.11.2019
//
// Copyright © 2019 Oleg Mosyagin. All rights reserved.

import UIKit

class ContactListViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: - Properties
    @IBOutlet var contactListTable:UITableView!
    
    
    private var viewModel = ContactListViewModel()
    
    
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: надо локализовать текст в строке ниже
        title = "Contact List"
    }
    
    
    
    // MARK: - Overridden methods
    override func createViewModel() {
        commonTypeViewModel = viewModel
    }
    
    
    
    // MARK: - Table view data source
    // MARK: Number of elements

    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contactList.value.count
    }
    
    // MARK: Heights for elements
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    internal func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // MARK: Cells and headers
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCellReuseID") as! ContactCell
        let contactModel = viewModel.contactList.value[indexPath.row]
        
        cell.nameLabel.text  = contactModel.fullName
        cell.emailLabel.text = contactModel.email
        // TODO: need to show avatar image from URL
        
        return cell
    }
    
    // MARK: Cells selection
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: add implementation of cell selection
        let selectedContact = viewModel.contactList.value[indexPath.row]
        print("Selected \(selectedContact.fullName)")
    }
}
