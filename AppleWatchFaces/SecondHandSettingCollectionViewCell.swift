//
//  SecondHandSettingCollectionViewCell.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 10/29/18.
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import UIKit
import SpriteKit

class SecondHandSettingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var skView : SKView!
    var secondHandType: SecondHandTypes = SecondHandTypes.SecondHandNodeTypeNone
    
//    override var isSelected: Bool{
//        didSet{
//            if self.isSelected {
//                debugPrint("selected cell secondHandType: " + secondHandType.rawValue)
//            } else {
//                debugPrint("DEselected cell secondHandType: " + secondHandType.rawValue)
//            }
//        }
//    }
}