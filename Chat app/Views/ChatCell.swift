//
//  ChatCell.swift
//  Chat app
//
//  Created by Amir Mahdi Soleimani on 11/8/19.
//  Copyright © 2019 Amir Mahdi Soleimani. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var profileImage: CircleImage!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var usernameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setupView(message: Message) {
        //profileImage.backgroundColor = UserDataService.instance.returnAvatarColor(component: message.userAvatarColor)
       // profileImage.image = UIImage(named: message.userAvatar)
        messageLbl.text = message.messageBody
        usernameLbl.text = message.userName
        timeStampLbl.text = UserDataService.instance.messsageActualTime(time: message.timeStamp)

        
        
    }

 
}
