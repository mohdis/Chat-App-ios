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
let URL_FIND_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let URL_GET_CHANNELS = "\(BASE_URL)/channel"
let URL_GET_MESSAGES_BY_CHANNEL = "\(BASE_URL)/message/byChannel/"

//MARK: Headers
let BEARER_HEADER = ["Authorization":"Bearer \(AuthService.instance.authToken)",
                     "Content-Type" : "application/json; charset=utf-8"]
let HEADER        = ["Content-Type" : "application/json; charset=utf-8"]

//MARK: Segues
let TO_LOGIN = "toLogin"
let UNWIND_TO_CHANNEL = "unwindSegueToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

//MARK: Cell indentifiers
let AVATER_PICKER_CELL = "avatarPickerCell"
let CHANNEL_CELL = "channelCell"
let CHAT_CELL = "chatCell"
let MY_CELL = "myCell"
//MARK: User defaults keys
let USER_EMAIL = "userEmail"
let LOGGED_IN_KEY = "loggedIn"
let TOKEN_KEY = "token"

//MARK: Notifications
let USER_DATA_CHANGED = Notification.Name("userDataChanged")
let CHANNELS_LOADED = Notification.Name("channelsLoaded")
let CHANNEL_SELECTED = Notification.Name("channelSelected")
//MARK: Tablefields
//Message table
let MESSAGE_ID = "_id"
let MESSAGE_MESSAGE_BODY = "messageBody"
let MESSAGE_USER_ID = "userId"
let MESSAGE_CHANNEL_ID = "channelId"
let MESSAGE_USER_NAME = "userName"
let MESSAGE_USER_AVATER = "userAvatar"
let MESSAGE_USER_AVATAR_COLOR = "userAvatarColor"
let MESSAGE_TIME_STAMP = "timeStamp"
//Channel table
let CHANNEL_ID = "_id"
let CHANNEL_NAME = "name"
let CHANNEL_DESCRIPTIOM = "description"
