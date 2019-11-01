//
//  AuthService.swift
//  Chat app
//
//  Created by Amir Mahdi Soleimani on 10/31/19.
//  Copyright © 2019 Amir Mahdi Soleimani. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

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
        let lowerCaseEmail = email.lowercased()
        
        let header = ["Content-Type" : "application/json; charset=utf-8"]
        let body : [String: Any] = ["password": password , "email": lowerCaseEmail]
        
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
    func loginUser (email: String, password: String, complection: @escaping completionHandler){
        
        let lowerCaseEmail = email.lowercased()
        
        let header = ["Content-Type" : "application/json; charset=utf-8"]
        let body : [String: Any] = ["password": password , "email": lowerCaseEmail]

        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            guard let dataResponse = response.data else {
                print(response.error)
                complection(false)
                return
            }
            let json = JSON(dataResponse)
            self.isLoggedIn = true
            self.authToken = json["token"].stringValue
            self.userEmail = json["user"].stringValue
            complection(true)
        }
    }
    func addUser(email: String, name: String, avatarName: String, avatarColor: String, complection: @escaping completionHandler) {
        let lowerCaseEmail = email.lowercased()
        
        let header = ["Content-Type" : "application/json; charset=utf-8",
                      "Authorization" : "Bearer \(authToken)" ]
        
        let body : [String: Any] = ["name": name , "email": lowerCaseEmail, "avatarName": avatarName, "avatarColor": avatarColor]
        
        Alamofire.request(URL_ADD_USER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            guard let dataResponse = response.data else {
                print(response.error)
                complection(false)
                return
            }
            let json  = JSON(dataResponse)
            let email = json["email"].stringValue
            let name = json["name"].stringValue
            let avatarName = json["avatarName"].stringValue
            let avatarColor = json["avatarColor"].stringValue
            let id = json["_id"].stringValue
            
            UserDataService.instance.setUserData(id: id, name: name, email: email, avatarName: avatarName, avatarColor: avatarColor)
            complection(true)
        }
    }
}

