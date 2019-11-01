//
//  CreateAccountViewController.swift
//  Chat app
//
//  Created by Amir Mahdi Soleimani on 10/31/19.
//  Copyright © 2019 Amir Mahdi Soleimani. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var userImg: UIButton!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var avatarName = "smackProfileIcon"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var backgroundColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorChangeState(state: false)
        setupGesture()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupAvatarImage()
    }
   

    @IBAction func closeBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL , sender: nil)
    }
    
    @IBAction func generateColorPressed(_ sender: Any) {
      
        UIView.animate(withDuration: 0.3) {
            self.userImg.backgroundColor = self.generateRnadomColor()
        }
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        
        guard let email = emailTxt.text , emailTxt.text != "" else {return}
        guard let password = passwordTxt.text , passwordTxt.text != "" else {return}
        guard let username = usernameTxt.text , usernameTxt.text != "" else {return}
        
        activityIndicatorChangeState(state: true)
        
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success {
            print ("user registered")
                AuthService.instance.loginUser(email: email, password: password, complection: { (success) in
                    if success {
                        print ("user loggedin")
                        AuthService.instance.addUser(email: email, name: username, avatarName: self.avatarName, avatarColor: self.avatarColor, complection: self.loginUserHandler(success:))
                        
                    }
                })
        }
      }
    }

    @IBAction func chooseAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier:TO_AVATAR_PICKER , sender: nil)
    }
    
    
    func generateRnadomColor () -> UIColor {
        let red:   CGFloat   = CGFloat(arc4random_uniform(255))/255
        let green: CGFloat   = CGFloat(arc4random_uniform(255))/255
        let blue:  CGFloat   = CGFloat(arc4random_uniform(255))/255
        return  UIColor(displayP3Red: red, green: green, blue: blue, alpha: 1)
    }
    
    func activityIndicatorChangeState (state: Bool) {
        if state {
            activityIndicator.startAnimating()
            activityIndicator.isHidden = false
        } else {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
        emailTxt.isEnabled = !state
        passwordTxt.isEnabled = !state
        usernameTxt.isEnabled = !state
    }
    
    func loginUserHandler (success: Bool) {
        if success {
            print("user added")
            self.activityIndicatorChangeState(state: false)
            NotificationCenter.default.post(name: USER_DATA_CHANGED, object: nil)
            self.performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
            
        }
    }
    
    func setupAvatarImage() {
        
        if UserDataService.instance.avatarName != "" {
            userImg.setImage(UIImage(named: UserDataService.instance.avatarName), for: .normal)
            avatarName = UserDataService.instance.avatarName
            if avatarName.contains("light") && backgroundColor == nil {
                userImg.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            }
        }
        
    }
    
    func setupGesture (){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissTextFields))
        view.addGestureRecognizer(tap)
    }
    
   @objc func dismissTextFields () {
        view.endEditing(true)
    }
}
