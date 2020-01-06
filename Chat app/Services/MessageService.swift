//
//  MessageService.swift
//  Chat app
//
//  Created by Amir Mahdi Soleimani on 11/7/19.
//  Copyright © 2019 Amir Mahdi Soleimani. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MesssageService  {
    static let instance = MesssageService()
    var channels = [Channel]()
    var messages = [Message]()
    var selectedChannel: Channel?
    
    func getAllChannels(complection: @escaping completionHandler) {
        self.channels.append(contentsOf: DBManager.instance.loadChannels())
        
    Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
        guard let dataResponse = response.data else {
            complection(false)
            return
        }
        if dataResponse.description == "0 bytes" {
            complection(true)
            return
        }
        var onlineChannels = [Channel]()
        let channels = JSON(dataResponse).array!
        for channel in channels {
            let id = channel["_id"].stringValue
            let name = channel["name"].stringValue
            let description = channel["description"].stringValue
            
            let newChannel = Channel(id: id, description: description, name: name)
            onlineChannels.append(newChannel)
            
        }
        if onlineChannels.count > self.channels.count {
            DBManager.instance.insertChannels(channels: Array(onlineChannels[self.channels.count..<onlineChannels.count]))
        }
        
        self.clearChannel()
        self.channels.append(contentsOf: onlineChannels)
        NotificationCenter.default.post(name: CHANNELS_LOADED, object: nil)
        complection(true)
        
        }
    }
    func getMessagesByChannel(channelId: String, complection: @escaping completionHandler){
        self.clearMessage()
        self.messages.append(contentsOf: DBManager.instance.loadMessages(channelId: channelId))
        
        Alamofire.request("\(URL_GET_MESSAGES_BY_CHANNEL)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            guard let data = response.data else {
                complection(false)
                print(response.error)
                return
            }
            if data.description == "0 bytes" {
                complection(true)
                return
            }
            var onlineMessages = [Message]()
            let messages = JSON(data).array
            for message in messages! {
                let id = message["_id"].stringValue
                let messageBody = message["messageBody"].stringValue
                let channelId = message["channelId"].stringValue
                let userId = message["userId"].stringValue
                let userName = message["userName"].stringValue
                let userAvatar = message["userAvatar"].stringValue
                let userAvatarColor = message["userAvatarColor"].stringValue
                let timeStamp = message["timeStamp"].stringValue
                
                let newMessage = Message(id: id, messageBody: messageBody, channelId: channelId, userId: userId, userName: userName, userAvatar: userAvatar, userAvatarColor: userAvatarColor, timeStamp: timeStamp)
                    onlineMessages.append(newMessage)
            }
            if onlineMessages.count > self.messages.count {
                DBManager.instance.insertMessages(messages: Array(onlineMessages[self.messages.count..<onlineMessages.count]))
            }
            self.clearMessage()
            self.messages.append(contentsOf: onlineMessages)
            complection(true)

        }
    }
    func clearChannel() {
        channels.removeAll()
    }
    func clearMessage() {
        messages.removeAll()
    }
}
