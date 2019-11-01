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
    
    var avatarName = "smackProfileIcon"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func closeBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL , sender: nil)
    }
    
    @IBAction func generateColorPressed(_ sender: Any) {
        
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        
        guard let email = emailTxt.text , emailTxt.text != "" else {return}
        guard let password = passwordTxt.text , passwordTxt.text != "" else {return}
        guard let username = usernameTxt.text , usernameTxt.text != "" else {return}

        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success {
            print ("user registered")
                AuthService.instance.loginUser(email: email, password: password, complection: { (success) in
                    if success {
                        print ("user loggedin")
                        AuthService.instance.addUser(email: email, name: username, avatarName: self.avatarName, avatarColor: self.avatarColor, complection: { (success) in
                            if success {
                                print("user added")
                                self.performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
                            }
                        })
                        
                    }
                })
        }
      }
    }
    
    @IBAction func chooseAvatarPressed(_ sender: Any) {
        
    }
}
