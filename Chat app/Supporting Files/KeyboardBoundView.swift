//
//  KeyboardBoundView.swift
//  SmackAlpha
//
//  Created by Jonny B on 7/11/17.
//  Copyright © 2017 Jonny B. All rights reserved.
//

import UIKit

extension UIView {
    
     func bindToKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if frame.origin.y == 0 {
                frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if frame.origin.y != 0 {
            frame.origin.y = 0
        }
    }
}
