//
//  UIViewExtenstion.swift
//  Chat app
//
//  Created by Amir Mahdi Soleimani on 1/6/20.
//  Copyright © 2020 Amir Mahdi Soleimani. All rights reserved.
//

import Foundation

extension UIView {
    
    func customizeView(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor){
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    func customizeView(shadowColor: UIColor, shadowRadius: CGFloat, shadowOpacity: Float ){
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
}
}

