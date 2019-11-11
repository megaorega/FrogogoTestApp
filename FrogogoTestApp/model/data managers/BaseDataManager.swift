// FrogogoTestApp
// Created on 10.11.2019
//
// Copyright © 2019 Oleg Mosyagin. All rights reserved.

import Foundation


class BaseDataManager {
    // MARK: - Properties
    static let notificationPayloadKey = "payload"
    
    
    
    // MARK: - Custom open/public/internal methods
    func post(notification: Notification.Name, withPayload payload:Any! = nil) {
        var userInfoToPost:[String:Any]? = nil
        if (payload != nil) {
            userInfoToPost = [BaseDataManager.notificationPayloadKey: payload!]
        }
        
        NotificationCenter.default.post(name    : notification,
                                        object  : self,
                                        userInfo: userInfoToPost)
    }
}
