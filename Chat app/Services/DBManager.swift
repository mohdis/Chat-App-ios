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
                    let query = ""
                    do {
                        try database.executeUpdate(query, values: nil)
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
}
