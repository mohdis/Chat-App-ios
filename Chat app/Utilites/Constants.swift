//
//  File.swift
//  Chat app
//
//  Created by Amir Mahdi Soleimani on 10/31/19.
//  Copyright © 2019 Amir Mahdi Soleimani. All rights reserved.
//

import Foundation

typealias completionHandler =  (_ success: Bool) -> Void

//MARK: Urls
let BASE_URL = "http://127.0.0.1:3005/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_ADD_USER = "\(BASE_URL)user/add"

//MARK: Segue
let TO_LOGIN = "toLogin"
let UNWIND_TO_CHANNEL = "unwindSegueToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

//MARK: Cell indentifier
let AVATER_PICKER_CELL = "avatarPickerCell"
//MARK: User defaults keys
let USER_EMAIL = "userEmail"
let LOGGED_IN_KEY = "loggedIn"
let TOKEN_KEY = "token"
