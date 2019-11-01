//
//  ChannelViewController.swift
//  Chat app
//
//  Created by Amir Mahdi Soleimani on 10/30/19.
//  Copyright © 2019 Amir Mahdi Soleimani. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImg: CircleImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.revealViewController()?.rearViewRevealWidth = view.frame.width - 60
        
        NotificationCenter.default.addObserver(self, selector: #selector(userDataChanged), name: USER_DATA_CHANGED, object: nil)
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            
           let profileViewController = ProfileViewController()
           profileViewController.modalPresentationStyle = .custom
           present(profileViewController, animated: true, completion: nil)
            
        } else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    @IBAction func unwindToChannelViewController (segue: UIStoryboardSegue){
        
    }
    
   @objc func userDataChanged() {
    
    if AuthService.instance.isLoggedIn {
        loginBtn.setTitle(UserDataService.instance.name, for: .normal)
        userImg.image = UIImage(named: UserDataService.instance.avatarName)
        userImg.backgroundColor = UserDataService.instance.returnAvatarColor(component: UserDataService.instance.avatarColor)

    } else {
        loginBtn.setTitle("Login", for: .normal)
        userImg.image = UIImage(named: "smackProfileIcon")
        userImg.backgroundColor = UIColor.clear
    }
        
    }
}
