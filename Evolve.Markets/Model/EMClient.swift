//
//  EMClient.swift
//  Evolve.Markets
//
//  Created by atao1 on 5/27/18.
//  Copyright © 2018 atao. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper


class EMClient: NSObject {
    var sessionID: String = ""
    var user: EMUser!
    var accountDidChange = false
    
    //MARK: Parameters
    func loginMethod(email: String, password: String, completion: @escaping(Error?) -> Void) {
        var methodParameters: [String: Any] = [:]
        
        methodParameters["email"] = email
        methodParameters["password"] = password
        methodParameters["g-recaptcha-response"] = ""
        methodParameters["platform"] = "mt4"
        methodParameters["login"] = "Log In"
        methodParameters["hash"] = ""
        
        EMClient.sharedInstance().getSessionID(parameters: methodParameters) { (error) in
            if error != nil {
                completion(error)
                return
            } else {
                EMClient.sharedInstance().loginWithSessionID() { (error) in
                    if error != nil {
                        completion(error)
                    } else {
                        completion(nil)
                    }
                }
            }
        }
    }
    
    //MARK: Initial Login
    func getSessionID(parameters: Parameters, completion: @escaping(Error?) -> Void) {
        let baseMethod = "https://mt5.clients.evolve.markets/login/"
        
        if !(HTTPCookieStorage.shared.cookies?.isEmpty)! {
            HTTPCookieStorage.shared.deleteCookie(HTTPCookieStorage.shared.cookies![0])
        }
        
        let request = Alamofire.request(baseMethod, method: .post, parameters: parameters, encoding: URLEncoding.default)
        
        request.response {( response) in
            if response.error != nil {
                completion(response.error)
            }
            EMClient.sharedInstance().sessionID = HTTPCookieStorage.shared.cookies!.first!.value
            completion(nil)
        }
    }
    //MARK: Login With Session ID
    func loginWithSessionID(completion: @escaping(Error?) -> Void) {
        let baseURL = "https://mt5.clients.evolve.markets/api/user/info/"
        let methodParameters: Parameters = ["sessionid":sessionID]
        let request = Alamofire.request(baseURL, method: .post, parameters: methodParameters, encoding: JSONEncoding.default)
        
        request.responseObject { (response: DataResponse<EMUser>) in
            
            let accounts = response.result.value
            if response.error != nil {
                completion(response.error)
            }
            
            EMClient.sharedInstance().user = accounts
            
            completion(nil)
        }
    }
    //MARK: Demo Add Funds
    func demoPostFunds(accountNumber: Int, amount: Double, completion: @escaping(Error?) -> Void) {
        let baseURL = "\(EMClient.Constants.ApiMethods.demoPostMethod)?sessionid=\(sessionID)"
        let methodParameters: Parameters = ["accountid":"\(accountNumber)", "amount":"\(amount)"]
        let request = Alamofire.request(baseURL, method: .post, parameters: methodParameters, encoding: URLEncoding.default)
        
        request.responseJSON {(response) in
            if response.error != nil {
                completion(response.error)
            }
            
            EMClient.sharedInstance().loginWithSessionID() { (error) in
                if error != nil {
                    completion(error)
                }
                completion(nil)
            }
        }
    }
    
    func deleteAccount(accountNumber: Int, completion: @escaping(Error?) -> Void) {
        let methodParameters: Parameters = ["accountid":"\(accountNumber)"]
        let request = Alamofire.request(EMClient.Constants.ApiMethods.deleteAccountMethod, method: .post, parameters: methodParameters, encoding: URLEncoding.default)
        
        request.responseJSON {(response) in
            if response.error != nil {
                completion(response.error)
            }
            EMClient.sharedInstance().loginWithSessionID() { (error) in
                if error != nil {
                    completion(response.error)
                }
                completion(nil)
            }
        }
    }
    
    //MARK: Update account method
    func updateAccount(accountId: Int, accountType: String, updateType: String, updatedItem: String, completion: @escaping (Error?) -> Void) {
        let baseURL = EMClient.Constants.ApiMethods.updateAccountMethod
        let methodParameters: Parameters = ["sessionid":sessionID, "update": updateType, "accountid":accountId, "type":accountType, updateType: updatedItem]
        
        let request = Alamofire.request(baseURL, method: .post, parameters: methodParameters, encoding: JSONEncoding.default)
        
        request.response{ (response) in
            if response.error != nil {
                completion(response.error)
            }
            EMClient.sharedInstance().loginWithSessionID() { (error) in
                if error != nil {
                    completion(response.error)
                }
                completion(nil)
            }
        }
    }
    
    //MARK: Log Out and Delete Session
    func deleteSession(completion: @escaping(Error?) -> Void) {
        let baseURL = "\(EMClient.Constants.ApiMethods.logoutUserMethod)?sessionid=\(sessionID)"
        
        let request = Alamofire.request(baseURL, method: .get, encoding: URLEncoding.default)
        if !(HTTPCookieStorage.shared.cookies?.isEmpty)! {
            for cookie in HTTPCookieStorage.shared.cookies! {
                HTTPCookieStorage.shared.deleteCookie(cookie)
            }
        }
        request.response {(response) in
            if response.error != nil {
                completion(response.error)
            }
            completion(nil)
        }
    }
    class func sharedInstance() -> EMClient {
        struct Singleton {
            static var sharedInstance = EMClient()
        }
        return Singleton.sharedInstance
    }
}
