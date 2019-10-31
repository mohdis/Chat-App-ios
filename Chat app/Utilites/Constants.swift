//
//  File.swift
//  Chat app
//
//  Created by Amir Mahdi Soleimani on 10/31/19.
//  Copyright © 2019 Amir Mahdi Soleimani. All rights reserved.
//

import Foundation
//MARK:
typealias completionHandler =  (_ success: Bool) -> Void
//MARK: Urls
let BASE_URL = "http://localhost:3005/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
//MARK: Segue
let TO_LOGIN = "toLogin"
let UNWIND_TO_CHANNEL = "unwindSegueToChannel"

//MARK: User defaults
let USER_EMAIL = "userEmail"
let LOGGED_IN_KEY = "loggedIn"
let TOKEN_KEY = "token"
