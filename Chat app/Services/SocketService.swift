//
//  SocketService.swift
//  Chat app
//
//  Created by Amir Mahdi Soleimani on 11/7/19.
//  Copyright © 2019 Amir Mahdi Soleimani. All rights reserved.
//

import UIKit
import SocketIO
class SocketService: NSObject {
    
    static let instance = SocketService()
    
    let socketManager: SocketManager
    let socket: SocketIOClient
    
    override init() {
        socketManager = SocketManager(socketURL: URL(string: BASE_URL)!)
        socket = socketManager.defaultSocket
        super.init()
    }
    func establishConnection() {
        socket.connect()
    }
    func closeConnection() {
        socket.disconnect()
    }
    func addChannel(ChannelName: String, ChannelDecription: String, complection: completionHandler) {
        socket.emit("newChannel", ChannelName, ChannelDecription)
        complection(true)
    }
    func getChannel (complection: @escaping completionHandler){
        socket.on("channelCreated") { (dataArray, ack) in
            
            guard let name = dataArray[0] as? String else {return}
            guard let description = dataArray[1] as? String else {return}
            guard let id = dataArray[2] as? String else {return}
            
            let channel = Channel(id: id, description: description, name: name)
            MesssageService.instance.channels.append(channel)
            DBManager.instance.insertChannels(channels: [channel])

            complection(true)
        }
    }
    func addMessage(messsageBody: String, channelId: String, complection: completionHandler) {
        let user = UserDataService.instance
        socket.emit("newMessage", messsageBody, user.id, channelId, user.name, user.avatarName, user.avatarColor)
        complection(true)
    }
    
    func getMessages(complection: @escaping completionHandler) {
        socket.on("messageCreated") { (dataArray, ack) in
            
            guard let messageBody = dataArray[0] as? String else {return}
            guard let userId = dataArray[1] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            guard let username = dataArray[3] as? String else {return}
            guard let userAvatar = dataArray[4] as? String else {return}
            guard let userAvatarColor = dataArray[5] as? String else {return}
            guard let messageId = dataArray[6] as? String else {return}
            guard let timeStamp = dataArray[7] as? String else {return}
            
            if channelId == MesssageService.instance.selectedChannel?.id {
                
                let newMessage = Message(id: messageId, messageBody: messageBody, channelId: channelId, userId: userId, userName: username, userAvatar: userAvatar, userAvatarColor: userAvatarColor, timeStamp: timeStamp)
                MesssageService.instance.messages.append(newMessage)
                DBManager.instance.insertMessages(messages: [newMessage])
                complection(true)
                
            } else {
                complection(false)
            }

        }
    }
    func startChat(username: String, channelId: String) {
        socket.emit("startType", username, channelId)
        
    }
    func endChat(username: String){
        socket.emit("stopType", username)
    }
    func userTypingUpdate (complection: @escaping (_ typingUsers: [String: String]) -> Void) {
        
        socket.on("userTypingUpdate") { (dataArray, ack) in
            guard let typingUsers = dataArray[0] as? [String: String] else {return}
            complection(typingUsers)
            
        }
        
    }
}
