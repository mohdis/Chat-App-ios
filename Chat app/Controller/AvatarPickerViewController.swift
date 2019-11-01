//
//  AvatarPickerViewController.swift
//  Chat app
//
//  Created by Amir Mahdi Soleimani on 11/1/19.
//  Copyright © 2019 Amir Mahdi Soleimani. All rights reserved.
//

import UIKit

class AvatarPickerViewController: UIViewController {

    @IBOutlet weak var segmentControll: UISegmentedControl!
    @IBOutlet weak var collectionvView: UICollectionView!
    var avatarMode: AvaterMode = .dark
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionvView.delegate = self
        collectionvView.dataSource = self

    }
    

    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func pickerChanged(_ sender: Any) {
        if segmentControll.selectedSegmentIndex == 0 {
            avatarMode = .dark
        } else{
            avatarMode = .light
        }
        collectionvView.reloadData()
    }
}
extension AvatarPickerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AVATER_PICKER_CELL, for: indexPath) as! AvatarPickerCell
        cell.setViews(number: indexPath.row, avatarMode: avatarMode)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var numberOfColumns: CGFloat = 3
        if UIScreen.main.bounds.width > 320 {
            numberOfColumns = 4
        }
        
        let padding: CGFloat = 20
        let spaceBetweenCell: CGFloat = 20
        let  cellSize  = ((UIScreen.main.bounds.width - padding) - (spaceBetweenCell * (numberOfColumns - 1)))/numberOfColumns
        
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UserDataService.instance.setAvatarName(avatarName: "\(avatarMode.rawValue)\(indexPath.row)")
        dismiss(animated: true, completion: nil)
    }
}


