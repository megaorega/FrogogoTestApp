// FrogogoTestApp
// Created on 11.11.2019
//
// Copyright © 2019 Oleg Mosyagin. All rights reserved.

import Foundation
import Alamofire
import SwiftyJSON



typealias CompleteHandler = (_ isOK:Bool, _ response:JSON?, _ error:Error?) -> Void



class APIConnector {
    // MARK: - Properties
    static let shared = APIConnector()
    
    private let apiHost = "https://frogogo-test.herokuapp.com"
    
    
    
    func requestGET(_ address:String, params:[String:String]? = nil, completeHandler:@escaping CompleteHandler) {
        
        print("\(type(of: self)): sending GET request to \"\(address)\"")
        
        Alamofire.request(apiHost + "/" + address,
                          method    : .get,
                          parameters: params,
                          encoding  : URLEncoding.methodDependent,
                          headers   : nil)
            .responseJSON { (rawResponse) in
                print("\(type(of: self)): Response from \"\(address)\" received")
                
                let response = JSON(rawResponse.data!)
                let error = rawResponse.error
                let isOK = (error == nil)
                
                completeHandler(isOK, response, error)
        }
    }
}
