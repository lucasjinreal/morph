//
//  YuanCollectionViewCell.swift
//  Morph
//
//  Created by JinTian on 5/15/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class YuanCollectionViewCell: UICollectionViewCell {
    
    
   
    @IBOutlet weak var picture: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //self.contentView.backgroundColor = UIColor(red: 23/255, green: 232/255, blue: 233/255, alpha: 1)
        self.picture.layer.cornerRadius = 18
        self.picture.layer.masksToBounds = true
        
        let blureffect = UIBlurEffect(style: .light)
        let visualeffectview = UIVisualEffectView(effect: blureffect)
        self.picture.addSubview(visualeffectview)
        
    }
       
}
