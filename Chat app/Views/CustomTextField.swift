//
//  CustomTextField.swift
//  Chat app
//
//  Created by Amir Mahdi Soleimani on 11/1/19.
//  Copyright © 2019 Amir Mahdi Soleimani. All rights reserved.
//

import UIKit
@IBDesignable
class CustomTextField: UITextField {

    override func awakeFromNib() {
        setup()

    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    func setup() {
       self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.1450980392, green: 0.3725490196, blue: 0.3333333333, alpha: 0.8470588235) ])
    }
}
