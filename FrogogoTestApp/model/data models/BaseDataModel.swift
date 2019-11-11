// FrogogoTestApp
// Created on 10.11.2019
//
// Copyright © 2019 Oleg Mosyagin. All rights reserved.

import Foundation
import SwiftyJSON



class BaseDataModel {
    // MARK: - Lifecycle methods
    init() {
        
    }
    
    init(withJSON jsonData:JSON) {
        update(withJSON: jsonData)
    }
    
    
    
    // MARK: - Custom open/public/internal methods
    /**
     Override this method to parse your model from JSON object
     */
    func update(withJSON jsonData:JSON) {
        // default implementation does nothing
    }
}
