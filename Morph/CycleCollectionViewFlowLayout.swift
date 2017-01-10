//
//  CycleCollectionViewFlowLayout.swift
//  Morph
//
//  Created by JinTian on 8/23/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class CycleCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        if let collectionView = self.collectionView{
            self.minimumLineSpacing = 0
            self.minimumInteritemSpacing = 0
            self.itemSize.width = UIScreen.main.bounds.width
            self.itemSize.height = collectionView.frame.height
            
            self.scrollDirection = .horizontal
            collectionView.isPagingEnabled = true
            
        }
    }


}
