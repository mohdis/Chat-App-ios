//
//  GradiantView.swift
//  Chat app
//
//  Created by Amir Mahdi Soleimani on 10/30/19.
//  Copyright © 2019 Amir Mahdi Soleimani. All rights reserved.
//

import UIKit

@IBDesignable
class GradiantView: UIView {
    
  @IBInspectable  var topColor: UIColor  = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1){
        didSet {
            self.setNeedsLayout()
        }
    }
    @IBInspectable var middleColor: UIColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    @IBInspectable var bottonColor: UIColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1) {
        didSet {
        self.setNeedsLayout()
        }
    }
    @IBInspectable var startX: Double = 0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    @IBInspectable var startY: Double = 0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    @IBInspectable var endX: Double = 1 {
        didSet {
            self.setNeedsLayout()
        }
    }
    @IBInspectable var endY: Double = 1 {
        didSet {
            self.setNeedsLayout()
        }
    }
    override func layoutSubviews() {
        let gradiant = CAGradientLayer()
        gradiant.colors = [topColor.cgColor, bottonColor.cgColor]
        gradiant.startPoint = CGPoint(x: startX, y: startY)
        gradiant.endPoint  =  CGPoint(x: endX, y: endY)
        gradiant.frame = self.frame
        self.layer.insertSublayer(gradiant, at: 0)
    }
    override func awakeFromNib() {
        self.setNeedsLayout()

    }

}
