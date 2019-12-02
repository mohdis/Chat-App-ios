//
//  ChannelCell.swift
//  Chat app
//
//  Created by Amir Mahdi Soleimani on 11/7/19.
//  Copyright © 2019 Amir Mahdi Soleimani. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {
    @IBOutlet weak var lable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func setupView (channel: Channel) {
        lable.text = "#\(channel.name)"
        layoutIfNeeded()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
           backgroundColor = UIColor(white: 1, alpha: 0.2)
        } else {
           backgroundColor = UIColor.clear
        }
    }

}
