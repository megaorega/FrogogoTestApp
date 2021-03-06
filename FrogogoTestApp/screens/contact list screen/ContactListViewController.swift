// FrogogoTestApp
// Created on 09.11.2019
//
// Copyright © 2019 Oleg Mosyagin. All rights reserved.

import UIKit
import SDWebImage

class ContactListViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: - Properties
    @IBOutlet var screenTitleLabel:UILabel!
    @IBOutlet var contactListTable:UITableView!
    let refreshControl = UIRefreshControl()
    
    private var viewModel = ContactListViewModel()
    
    
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRefreshControl()
    }
    
    
    
    // MARK: - Overridden methods
    override func createViewModel() {
        commonTypeViewModel = viewModel
    }
    
    override func addBindings() {
        super.addBindings()
        
        viewModel.screenTitle.bind {[unowned self] newScreenTitle in
            self.screenTitleLabel.text = newScreenTitle
        }
        viewModel.segueIdentifierToPerform.bind {[unowned self] segueID in
            guard let segueToPerform = segueID else { return }
            self.performSegue(withIdentifier: segueToPerform, sender: self)
        }
        viewModel.refreshStatusString.bind {[unowned self] newRefreshStatusString in
            self.refreshControl.attributedTitle = NSAttributedString(string: newRefreshStatusString)
        }
        viewModel.refreshingActive.bind {[unowned self] isRefreshing in
            if (isRefreshing) {
                self.refreshControl.beginRefreshing()
            } else {
                self.refreshControl.endRefreshing()
            }
        }
        viewModel.contactList.bind {[unowned self] _ in
            self.contactListTable.reloadData()
        }
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
        cell.avatarImage.sd_setImage(with: URL(string: contactModel.avatarURL), placeholderImage: UIImage(systemName: "person.crop.circle"))
        
        return cell
    }
    
    // MARK: Cells selection
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedContact = viewModel.contactList.value[indexPath.row]
        viewModel.triggerEditContact(selectedContact)
    }
    
    
    
    // MARK: - Custom private methods
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(handleRefreshControlTriggered), for: .valueChanged)
        contactListTable.refreshControl = refreshControl
    }
    
    
    
    // MARK: - IBActions and handlers
    @IBAction func handleAddContactBtnDidTap() {
        viewModel.triggerAddContact()
    }
    @objc private func handleRefreshControlTriggered() {
        viewModel.triggerContactsRefreshing()
    }
}
