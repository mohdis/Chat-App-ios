//
//  AuthService.swift
//  Chat app
//
//  Created by Amir Mahdi Soleimani on 10/31/19.
//  Copyright © 2019 Amir Mahdi Soleimani. All rights reserved.
//

import Foundation
import Alamofire

class AuthService {
    static let instance: AuthService = AuthService()
    let userDefaults = UserDefaults.standard
    var isLoggedIn: Bool  {
        set {
            userDefaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
        get {
           return userDefaults.bool(forKey: LOGGED_IN_KEY)
        }
    }
    var userEmail: String {
        set {
            userDefaults.set(newValue, forKey: USER_EMAIL)
        }
        get {
           return userDefaults.object(forKey: USER_EMAIL) as! String
        }
    }
    var authToken: String {
        set {
            userDefaults.set(newValue, forKey: TOKEN_KEY)
        }
        get {
          return  userDefaults.object(forKey: TOKEN_KEY) as! String
        }
    }
    
    func registerUser (email: String, password: String, comlection: @escaping completionHandler) {
        let header = ["Content-Type" : "application/json; charset=utf-8"]
        
        let body : [String: Any] = ["password": password,
                                         "email": email]
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (reponse) in
            if let error = reponse.error {
                comlection(false)
                print(error)
                return
            }
            print(reponse.description)
            comlection(true)
            
        }
        }
        
    
}

