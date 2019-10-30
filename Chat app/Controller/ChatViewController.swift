//
//  ChatViewController.swift
//  Chat app
//
//  Created by Amir Mahdi Soleimani on 10/30/19.
//  Copyright © 2019 Amir Mahdi Soleimani. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var btnSlider: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        initSlider ()
    }
    
    func initSlider() {
        
        btnSlider.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())

    }
}
