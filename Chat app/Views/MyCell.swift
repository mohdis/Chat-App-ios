//
//  TableViewCell.swift
//  Chat app
//
//  Created by Amir Mahdi Soleimani on 1/6/20.
//  Copyright © 2020 Amir Mahdi Soleimani. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {

    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupView(message: Message){
        messageLbl.text = message.messageBody
        timeStampLbl.text = "12:33 PM" //message.timeStamp
    
     }

}
