//
//  CircleImage.swift
//  Chat app
//
//  Created by Amir Mahdi Soleimani on 11/1/19.
//  Copyright © 2019 Amir Mahdi Soleimani. All rights reserved.
//

import UIKit
@IBDesignable

class CircleImage: UIImageView {
  
    override func awakeFromNib() {
        self.layer.cornerRadius = self.bounds.width / 2
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    func setup () {
        self.layer.cornerRadius = self.bounds.width / 2

    }
}
