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
    var dataController: DataController!
    
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
                        return
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
                return
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
            
            if response.error != nil {
                completion(response.error)
                return
            }
            let accounts = response.result.value
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
                return
            }
            EMClient.sharedInstance().loginWithSessionID() { (error) in
                if error != nil {
                    completion(error)
                    return
                }
                completion(nil)
            }
            completion(nil)
        }
    }
    
    //MARK: Delete account
    func deleteAccount(accountNumber: Int, completion: @escaping(Error?) -> Void) {
        let methodParameters: Parameters = ["accountid":"\(accountNumber)"]
        let request = Alamofire.request(EMClient.Constants.ApiMethods.deleteAccountMethod, method: .post, parameters: methodParameters, encoding: URLEncoding.default)
        
        request.responseJSON {(response) in
            if response.error != nil {
                completion(response.error)
                return
            }
            EMClient.sharedInstance().loginWithSessionID() { (error) in
                if error != nil {
                    completion(response.error)
                    return
                }
                completion(nil)
                
            }
        }
    }
    
    //MARK: Update email settings
    func updateEmailSettings(switchState:Bool,switchName: String, completion: @escaping (Error?) -> Void) {
        let switchNum: String
        if switchState == true {
            switchNum = "1"
        } else {
            switchNum = "0"
        }
        let baseURL = EMClient.Constants.ApiMethods.updateUserMethod
        let methodParameters: Parameters = ["sessionid":sessionID, "update":"notification", "notification":switchName, "switch":switchNum]
        let request = Alamofire.request(baseURL, method: .post, parameters: methodParameters, encoding: JSONEncoding.default)
        
        request.response{ (response) in
            if response.error != nil {
                completion(response.error)
            } else {
                print(response)
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
                    return
                }
                completion(nil)
            }
        }
    }
    
    func postNewAccount(completion: @escaping(Error?) -> Void) {
        let baseURL = "\(EMClient.Constants.ApiMethods.postNewAccount)?sessionid=\(sessionID)"
        
        let request = Alamofire.request(baseURL, method: .post, encoding: JSONEncoding.default)
        request.response {(response) in
            if response.error != nil {
                completion(response.error)
                
            } else {
                
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
                return
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
