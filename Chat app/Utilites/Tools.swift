//
//  Tools.swift
//  Chat app
//
//  Created by Amir Mahdi Soleimani on 1/6/20.
//  Copyright © 2020 Amir Mahdi Soleimani. All rights reserved.
//

import Foundation
class Tools {
    
   static func messsageActualTime(time: String) -> String {
        let seperators = CharacterSet(charactersIn: "T.:")
        let parts = time.components(separatedBy: seperators)
        let hour:Int = Int(parts[1])!
        var timeSuffix = "AM"
        if hour > 12 {
            timeSuffix = "PM"
        }
        
        let actualTime = "\(parts[1]):\(parts[2]) \(timeSuffix)"
        
        
        return actualTime
    }

}
