//
//  LoginViewConroller.swift
//  Chat app
//
//  Created by Amir Mahdi Soleimani on 10/31/19.
//  Copyright © 2019 Amir Mahdi Soleimani. All rights reserved.
//

import UIKit

class LoginViewConroller: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var passwordTxt: CustomTextField!
    @IBOutlet weak var usernameTxt: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorChangeState(state: false)
        setGesture()
    }

    @IBAction func loginPressed(_ sender: Any) {
        guard let username = usernameTxt.text, usernameTxt.text != "" else {return}
        guard let password = passwordTxt.text, passwordTxt.text != "" else {return}
        activityIndicatorChangeState(state: true)
        
        AuthService.instance.loginUser(email: username, password: password) { (success) in
            if success {
                AuthService.instance.findUserByEmail(complection: self.findUserByEmailHandler(success:))
            }
        }
    }
    
    func findUserByEmailHandler(success: Bool){
        if success {
            NotificationCenter.default.post(name: USER_DATA_CHANGED, object: nil)
            self.activityIndicatorChangeState(state: false)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func activityIndicatorChangeState (state: Bool) {
        if state {
            activityIndicator.startAnimating()
            activityIndicator.isHidden = false
        } else {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
        passwordTxt.isEnabled = !state
        usernameTxt.isEnabled = !state
    }
    func setGesture(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(gesture)
    }
   @objc func closeKeyboard () {
        view.endEditing(true)
    }
}
