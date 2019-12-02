//
//  ChatViewController.swift
//  Chat app
//
//  Created by Amir Mahdi Soleimani on 10/30/19.
//  Copyright © 2019 Amir Mahdi Soleimani. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var typingUsersLbl: UILabel!
    @IBOutlet weak var messageTxt: CustomTextField!
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var btnSlider: UIButton!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var sendBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSlider()
        setupUser()
        setupNotifications()
        setupKeyboard()
        setupTableView()
        setupGetMessages()
        setupTypingUsers()
    }
    func setupGetMessages() {
        SocketService.instance.getMessages { (success) in
            if success {
                self.tableview.reloadData()
                let endIndex = IndexPath(row: MesssageService.instance.messages.count - 1 , section: 0)
                self.tableview.scrollToRow(at: endIndex, at: .middle, animated: true)
            }
        }
    }
    func setupTypingUsers() {
        SocketService.instance.userTypingUpdate { (typingUsers) in
            guard let myChannelId = MesssageService.instance.selectedChannel?.id else {return}
            var numberOfTypers = 0
            var typersNames = ""
            for (username, channelId) in typingUsers {
                if username != UserDataService.instance.name && channelId == myChannelId {
                if numberOfTypers == 0 {
                    typersNames = username
                } else {
                    typersNames += "\(typersNames), \(username)"
                }
                numberOfTypers += 1
            }
            }
            if numberOfTypers > 0 && AuthService.instance.isLoggedIn {
                
            
            var verb = "are"
            if numberOfTypers == 1 {
                verb = "is"
            }
                //self.typingUsersLbl.text = "\(typersNames) \(verb) typing"
            } else {
              //f  self.typingUsersLbl.text = " "
            }
        }
            
    }
    
    func setupKeyboard() {
        sendBtn.isHidden = true
        view.bindToKeyboard()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(tapGesture)
    }
  
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(userDataChanged), name: USER_DATA_CHANGED, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(channelSelected), name: CHANNEL_SELECTED, object: nil)
    }
    func initSlider() {
        
        btnSlider.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.rightRevealToggle(animated:)), for: .touchUpInside)
       
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
       
    }
    func setupUser () {
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (success) in
                if (success){
                    NotificationCenter.default.post(name: USER_DATA_CHANGED, object: nil)
                }
            }
            
        }
    }
    func onLoginGetMessages() {
        MesssageService.instance.getAllChannels { (success) in
            if success {
                if MesssageService.instance.channels.count > 0 {
                    MesssageService.instance.selectedChannel = MesssageService.instance.channels[0]
                    self.channelSelected()
        } else {
                    self.channelNameLbl.text = "Chat App"

        }
        }
        }
    }
    func getMessages() {
        guard let ChannelId =  MesssageService.instance.selectedChannel?.id else {return}
            MesssageService.instance.getMessagesByChannel(channelId: ChannelId) { (success) in
                if success {
                    self.tableview.reloadData()
                }
        }
    }
    
    @objc func userDataChanged() {
        if AuthService.instance.isLoggedIn {
           onLoginGetMessages()
        } else {
            channelNameLbl.text = "Please Log in..."
            tableview.reloadData()
            self.typingUsersLbl.text = ""

        }
}
    @objc func channelSelected() {
        print(5)
        channelNameLbl.text = MesssageService.instance.selectedChannel?.name ?? "Chat App"
        self.getMessages()

    }
    @objc func endEditing() {
        view.endEditing(true)
    }
    
    var isTyping = false
    @IBAction func messageTxtEditingChanged(_ sender: Any) {
        
        if messageTxt.text == "" {
            sendBtn.isHidden = true
            isTyping = false
            SocketService.instance.endChat(username: UserDataService.instance.name)
        } else {
            if !isTyping {
                sendBtn.isHidden = false
                isTyping = true
                guard let channelId = MesssageService.instance.selectedChannel?.id else {return}
                 SocketService.instance.startChat(username: UserDataService.instance.name, channelId: channelId)

            }
        }
    }
    @IBAction func messageTxtEndEditing(_ sender: Any) {
     
    }
    
    @IBAction func sendMessagePressed(_ sender: Any) {
        
        guard let channelId = MesssageService.instance.selectedChannel?.id else { return }
        guard let messageBody = messageTxt.text, messageTxt.text != "" else { return }
        if AuthService.instance.isLoggedIn != true {return}
        
        SocketService.instance.addMessage(messsageBody: messageBody, channelId: channelId) { (success) in
            if success {
                messageTxt.text = ""
                messageTxt.resignFirstResponder()
               
            }
            
        }
    }
    
}
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
      return  1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return MesssageService.instance.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: CHAT_CELL, for: indexPath) as! ChatCell
        cell.setupView(message: MesssageService.instance.messages[indexPath.row])
        return cell
    }
    
   
    func setupTableView() {
        tableview.delegate = self
        tableview.dataSource = self
        tableview.estimatedRowHeight = 80
        tableview.rowHeight = 80
        
    }
}
