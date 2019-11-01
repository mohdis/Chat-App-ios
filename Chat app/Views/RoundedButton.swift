//
//  RoundedButton.swift
//  Chat app
//
//  Created by Amir Mahdi Soleimani on 11/1/19.
//  Copyright © 2019 Amir Mahdi Soleimani. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    @IBInspectable var isCircle: Bool = false {
        didSet {
            setupView()
        }
    }
    @IBInspectable var cornerRadius: CGFloat = 5 {
        didSet {
            setupView()
        }
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()

    }
    override func awakeFromNib() {
    setupView()
        
    }
    func setupView () {
        if isCircle {
            self.layer.cornerRadius = self.bounds.width / 2
        } else {
        self.layer.cornerRadius = cornerRadius
        }
    }
}
