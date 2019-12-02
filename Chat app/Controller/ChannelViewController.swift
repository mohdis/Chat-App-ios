//
//  ChannelViewController.swift
//  Chat app
//
//  Created by Amir Mahdi Soleimani on 10/30/19.
//  Copyright © 2019 Amir Mahdi Soleimani. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImg: CircleImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSocket()
        setupNotifications()
        
        self.revealViewController()?.rearViewRevealWidth = view.frame.width - 60
       
    }
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(userDataChanged), name: USER_DATA_CHANGED, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(channelsLoaded), name: CHANNELS_LOADED, object: nil)
    }
    func setupSocket() {
        SocketService.instance.getChannel { (success) in
            if success {
                self.tableview.reloadData()
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        userDataChanged() 
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
    
    @IBAction func AddChannelPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn  {
        let addChannelViewController = AddChannelViewController()
        addChannelViewController.modalPresentationStyle = .custom
        present(addChannelViewController, animated:true , completion: nil)
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
        tableview.reloadData()
    }
    }
    @objc func channelsLoaded() {
        tableview.reloadData()
    }
    

}

extension ChannelViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView () {
        tableview.delegate = self
        tableview.dataSource = self
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MesssageService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CHANNEL_CELL, for: indexPath) as! ChannelCell
        cell.setupView(channel: MesssageService.instance.channels[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedChannel = MesssageService.instance.channels[indexPath.row]
        MesssageService.instance.selectedChannel = selectedChannel
        NotificationCenter.default.post(name: CHANNEL_SELECTED, object: nil)
        
        self.revealViewController()?.revealToggle(animated: true)
        
    }
    
    
}
