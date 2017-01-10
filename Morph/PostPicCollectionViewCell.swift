//
//  PostPicCollectionViewCell.swift
//  Morph
//
//  Created by JinTian on 12/11/2016.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class PostPicCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var postPic: UIImageView!
    
    override func awakeFromNib() {
        self.postPic.layer.cornerRadius = 3
        self.postPic.layer.masksToBounds = true
        self.postPic.contentMode = .scaleAspectFill
    }
    
}
