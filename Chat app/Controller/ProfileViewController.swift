//
//  ProfileViewController.swift
//  Chat app
//
//  Created by Amir Mahdi Soleimani on 11/1/19.
//  Copyright © 2019 Amir Mahdi Soleimani. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupView()

    }


    @IBAction func closePressed(_ sender: Any) {
        dismissView()
    }
    @IBAction func logoutPressed(_ sender: Any) {
        UserDataService.instance.logout()
        dismissView()
    }
    func setupView() {
        profileImg.image = UIImage(named: UserDataService.instance.avatarName)
        usernameLbl.text = UserDataService.instance.name
        emailLbl.text = UserDataService.instance.email
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissView)))
    }
  @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
}
