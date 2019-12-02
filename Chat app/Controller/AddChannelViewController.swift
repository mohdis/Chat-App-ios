//
//  AddChannelViewController.swift
//  Chat app
//
//  Created by Amir Mahdi Soleimani on 11/7/19.
//  Copyright © 2019 Amir Mahdi Soleimani. All rights reserved.
//

import UIKit

class AddChannelViewController: UIViewController {
    
    @IBOutlet weak var nameTxt: CustomTextField!
    @IBOutlet weak var descriptionTxt: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    @IBAction func addChannelPressed(_ sender: Any) {
        guard let channelName = nameTxt.text, nameTxt.text != "" else {return}
        guard let channelDecription = descriptionTxt.text, descriptionTxt.text != "" else {return}
        SocketService.instance.addChannel(ChannelName: channelName, ChannelDecription: channelDecription) { (success) in
            if success {
                self.dismissView()
            }
        }
    }
    @IBAction func closePressed(_ sender: Any) {
        dismissView()
    }
    func setupView() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissView)))
    }
    @objc func dismissView () {
        dismiss(animated: true, completion: nil)
    }
}
