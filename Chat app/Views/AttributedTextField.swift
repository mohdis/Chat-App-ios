//
//  AttributedTextField.swift
//  Tooka
//
//  Created by Amir Mahdi Soleimani on 12/11/19.
//  Copyright © 2019 Amir Mahdi Soleimani. All rights reserved.
//

import UIKit

@IBDesignable
class AttributedTextField: UITextField {
    
    @IBInspectable var conrnerRadius: CGFloat = 5
    @IBInspectable var borderRadius: CGFloat = 5
    @IBInspectable var leftMargin: CGFloat = 5
    @IBInspectable var borderColor: UIColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    @IBInspectable var placeholderColor: UIColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeView()
        setLeftMargin()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        customizeView()
        setLeftMargin()
    }
    func customizeView(){
           customizeView(cornerRadius: conrnerRadius, borderWidth: borderRadius, borderColor: borderColor)
        guard let placeholder = placeholder else {return}
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: placeholderColor ])
    }
    func setLeftMargin(){
        let marginView = UIView(frame: CGRect(x: 0, y: 0, width: leftMargin, height: self.bounds.height))
        self.leftView = marginView
        self.leftViewMode = .always
    }
    

}



