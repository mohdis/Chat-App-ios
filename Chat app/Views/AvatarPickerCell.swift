//
//  AvatarPickerCell.swift
//  Chat app
//
//  Created by Amir Mahdi Soleimani on 11/1/19.
//  Copyright © 2019 Amir Mahdi Soleimani. All rights reserved.
//

import UIKit

enum AvaterMode: String {
    case dark
    case light
}

class AvatarPickerCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
  private func setupView() {
        layer.cornerRadius = 5
        layer.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    
    func setViews(number: Int, avatarMode: AvaterMode){
        image.image = UIImage(named: "\(avatarMode.rawValue)\(number)")
}
    
}
