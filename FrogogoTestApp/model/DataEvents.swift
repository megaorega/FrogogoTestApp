// FrogogoTestApp
// Created on 10.11.2019
//
// Copyright © 2019 Oleg Mosyagin. All rights reserved.

import Foundation

extension Notification.Name {
    // MARK: Contact list fetch notifications
    static let contactListFetchingOK    = Notification.Name("contactListFetchingOK")
    static let contactListFetchingFail  = Notification.Name("contactListFetchingFail")
    
    // MARK: Contact creation notifications
    static let contactCreationOK    = Notification.Name("contactCreationOK")
    static let contactCreationFail  = Notification.Name("contactCreationFail")
    
    // MARK: Contact edit save notifications
    static let contactEditSaveOK    = Notification.Name("contactEditSaveOK")
    static let contactEditSaveFail  = Notification.Name("contactEditSaveFail")
}
