//
//  UserDataService.swift
//  Chat app
//
//  Created by Amir Mahdi Soleimani on 11/1/19.
//  Copyright © 2019 Amir Mahdi Soleimani. All rights reserved.
//

import Foundation
class UserDataService {
   static let instance = UserDataService()
     var id: String {
    set {
      UserDefaults.standard.setValue(newValue, forKey: "user_id")
        }
        get {
            return UserDefaults.standard.object(forKey: "user_id") as! String
        }
        
    }
    public private(set) var name : String {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "user_name")
        }
        get {
            return UserDefaults.standard.object(forKey: "user_name") as! String
        }
        
    }
    public private(set) var email : String  {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "user_email")
        }
        get {
            return UserDefaults.standard.object(forKey: "user_email") as! String
        }
        
    }
    public private(set) var avatarName : String  {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "user_avaterName")
        }
        get {
            return UserDefaults.standard.object(forKey: "user_avaterName") as! String
        }
        
    }
    public private(set) var avatarColor : String  {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "user_avatarColor")
        }
        get {
            return UserDefaults.standard.object(forKey: "user_avatarColor") as! String
        }
        
    }
    
    func setUserData(id: String, name: String, email: String, avatarName: String, avatarColor: String){
        self.id = id
        self.name = name
        self.email = email
        self.avatarName = avatarName
        self.avatarColor = avatarColor
        
    }
    func setAvatarName(avatarName: String){
        self.avatarName = avatarName
    }
    func logout() {
        //id = ""
        //name = ""
      //  email = ""
       // avatarName = ""
        //avatarColor = ""
        AuthService.instance.logout()
        MesssageService.instance.clearChannel()
        MesssageService.instance.clearMessage()

        NotificationCenter.default.post(name: USER_DATA_CHANGED, object: nil)
    }
    
    func returnAvatarColor(component: String) -> UIColor {
        let scanner = Scanner(string: component)
        let skipped = CharacterSet(charactersIn: "[, ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        
        var r, g, b, a : NSString?
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)

        
        let defaultColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        guard let red = r else {return defaultColor}
        guard let green = g else {return defaultColor}
        guard let blue = b else {return defaultColor}
        guard let alpha = a else {return defaultColor}
        
       let returnColor = UIColor(displayP3Red: CGFloat(red.doubleValue), green: CGFloat(green.doubleValue), blue: CGFloat(blue.doubleValue), alpha: CGFloat(alpha.doubleValue))

        return returnColor
    }
    
}
