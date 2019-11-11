// FrogogoTestApp
// Created on 11.11.2019
//
// Copyright © 2019 Oleg Mosyagin. All rights reserved.

import Foundation
import Alamofire
import SwiftyJSON



typealias CompleteHandler = (_ isOK:Bool, _ response:JSON?) -> Void



class APIConnector {
    // MARK: - Properties
    static let shared = APIConnector()
    
    private let apiHost = "https://frogogo-test.herokuapp.com"
    
    
    
    // MARK: - Custom open/public/internal methods
    func requestGET(_ address:String, params:[String:Any]? = nil, completeHandler:@escaping CompleteHandler) {
        print("\(type(of: self)): sending GET request to \"\(address)\"")
        sendRequest(to: address, withMethod: .get, params: nil, andCompleteHandler: completeHandler)
    }
    
    func requestPOST(_ address:String, params:[String:Any], completeHandler:@escaping CompleteHandler) {
        print("\(type(of: self)): sending POST request to \"\(address)\"")
        sendRequest(to: address, withMethod: .post, params: params, andCompleteHandler: completeHandler)
    }
    
    func requestPATCH(_ address:String, params:[String:Any], completeHandler:@escaping CompleteHandler) {
        print("\(type(of: self)): sending PATCH request to \"\(address)\"")
        sendRequest(to: address, withMethod: .patch, params: params, andCompleteHandler: completeHandler)
    }
    
    
    
    // MARK: - Custom private methods
    private func sendRequest(to address:String, withMethod method:HTTPMethod, params:Parameters?, andCompleteHandler completeHandler:@escaping CompleteHandler) {
        
        request(apiHost + "/" + address,
                method: method,
                parameters: params,
                encoding: URLEncoding.methodDependent,
                headers: nil)
            
            .responseJSON { (rawResponse) in
                print("\(type(of: self)): Response from \"\(address)\" received")
                
                let statusCode = rawResponse.response!.statusCode
                let isOK  = statusCode >= 200 && statusCode < 300
                
                let response = JSON(rawResponse.data!)
                
                completeHandler(isOK, response)
        }
    }
}
