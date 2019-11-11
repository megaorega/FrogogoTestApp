// FrogogoTestApp
// Created on 10.11.2019
//
// Copyright © 2019 Oleg Mosyagin. All rights reserved.

import Foundation

class BaseDataManager {
    // MARK: - Properties
    /**
     Use this string to retrieve payload from Notification's userInfo
     */
    static let notificationPayloadKey = "payload"
    
    
    
    // MARK: - Custom open/public/internal methods
    /**
     Convenience method for subscribing to Notifications from default NotificationCenter.
     - Parameter payload: Object, that will be passed in userInfo wrapped in [key:value] dictionary, where key is always same – BaseDataManager.notificationPayloadKey
     */
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
