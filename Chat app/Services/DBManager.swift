//
//  File.swift
//  Chat app
//
//  Created by Amir Mahdi Soleimani on 1/6/20.
//  Copyright © 2020 Amir Mahdi Soleimani. All rights reserved.
//

import Foundation

class DBManager: NSObject {
    
    static let instance = DBManager()
    
    let databaseFileName = "database.sqlite"
    var databasePath: String!
    var database: FMDatabase!
    
    override init() {
        super.init()
        
        let documentDirectory: String = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        databasePath = documentDirectory.appending(databaseFileName)
    }
    
    
    func createDatabase() -> Bool {
        var created = false
        if !FileManager.default.fileExists(atPath: databasePath){
            database = FMDatabase(path: databasePath)
            if database != nil {
                if database.open() {
                    let createMessageTableQuery = "CREATE TABLE messages (\(MESSAGE_ID) TEXT NOT NULL, \(MESSAGE_MESSAGE_BODY) TEXT NOT NULL, \(MESSAGE_USER_ID) TEXT NOT NULL, \(MESSAGE_CHANNEL_ID) TEXT NOT NULL, \(MESSAGE_USER_NAME) TEXT NOT NULL,\(MESSAGE_USER_AVATER) TEXT NOT NULL, \(MESSAGE_USER_AVATAR_COLOR) TEXT NOT NULL, \(MESSAGE_TIME_STAMP) TEXT NOT NULL)"
                    
                    let createChannelTableQuery = "CREATE TABLE channels (\(CHANNEL_ID) TEXT NOT NULL, \(CHANNEL_NAME) TEXT NOT NULL, \(CHANNEL_DESCRIPTIOM) TEXT NOT NULL )"
                    
                   

                    do {
                        try database.executeUpdate(createMessageTableQuery, values: nil)
                        try database.executeUpdate(createChannelTableQuery, values: nil)
                        created = true
                    }catch{
                        print("Could't make table")
                        print(error.localizedDescription)
                    }
                    database.close()
                } else {
                    print("Could't open database")
                }
                
            }
           
        }
        return created
        
    }
    func openDatabase() -> Bool{
        
        if database == nil {
            if FileManager.default.fileExists(atPath: databasePath){
            database = FMDatabase(path: databasePath)
            }
       }
        if database != nil {
            if database.open() {
            return true
            }
        }
        return false
    }
    func insertChannels(channels: [Channel]){
        if openDatabase() {
            
            var query = ""
            for channel in channels {
               
                query += "INSERT INTO channels (\(CHANNEL_ID), \(CHANNEL_NAME), \(CHANNEL_DESCRIPTIOM)) VALUES ('\(channel.id)', '\(channel.name)', '\(channel.description)');"
            }
            if !database.executeStatements(query) {
                print("Could't insert into channels ")
                print(database.lastError(), database.lastErrorMessage())
            }
            database.close()
            
        }
        
    }
    func insertMessages(messages: [Message]){
        if openDatabase() {
         var query = ""
            for message in messages {
                query += "INSERT INTO messages (\(MESSAGE_ID), \(MESSAGE_MESSAGE_BODY), \(MESSAGE_USER_ID), \(MESSAGE_CHANNEL_ID), \(MESSAGE_USER_NAME), \(MESSAGE_USER_AVATER), \(MESSAGE_USER_AVATAR_COLOR), \(MESSAGE_TIME_STAMP)) VALUES ('\(message.id)', '\(message.messageBody)', '\(message.userId)', '\(message.channelId)', '\(message.userName)', '\(message.userAvatar)', '\(message.userAvatarColor)', '\(message.timeStamp)');"
            }
            if !database.executeStatements(query) {
                print("Could't insert into messages ")
                print(database.lastError(), database.lastErrorMessage())
            }
        database.close()
        }
    }
    
    func loadChannels() -> [Channel]{
        var channels = [Channel]()
        if openDatabase() {
            let query = "SELECT * FROM channels"
            do {
            let results = try database.executeQuery(query, values: nil)
                while results.next() {
                    channels.append(Channel(id: results.string(forColumn: CHANNEL_ID)!, description: results.string(forColumn: CHANNEL_DESCRIPTIOM)! , name: results.string(forColumn: CHANNEL_NAME)!))
                }
                //print(channels)
            }catch{
                print("Could't fetch Channels")
            }
            database.close()
        }
        return channels
    }
    func loadMessages(channelId: String) -> [Message] {
        var messages = [Message]()
        if openDatabase(){
            let query = "SELECT * FROM messages WHERE \(MESSAGE_CHANNEL_ID)=?"
            do {
                let result = try database.executeQuery(query, values: [channelId])
                while result.next() {
                    messages.append(Message(id: result.string(forColumn: MESSAGE_ID)!, messageBody: result.string(forColumn: MESSAGE_MESSAGE_BODY)!, channelId: result.string(forColumn: MESSAGE_CHANNEL_ID)!, userId: result.string(forColumn: MESSAGE_USER_ID)!, userName: result.string(forColumn: MESSAGE_USER_NAME)!, userAvatar: result.string(forColumn: MESSAGE_USER_AVATER)!, userAvatarColor: result.string(forColumn: MESSAGE_USER_AVATAR_COLOR)!, timeStamp: result.string(forColumn: MESSAGE_TIME_STAMP)!))
                }
               // print(messages)
            }catch{
                print("Could't fetch messages")
            }
          database.close()
        }
        return messages
    }
}
