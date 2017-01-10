//
//  PostPicCollectionViewFlowLayout.swift
//  Morph
//
//  Created by JinTian on 12/11/2016.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

//定义校园动态的tableview的collectionview的cell布局
class PostPicCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    var cellItemCount = 0
    var itemHeight:CGFloat = 110
    var collectionViewWidth: CGFloat = 0
    var collectionViewHeight: CGFloat = 0
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func prepare() {
        if self.collectionView != nil{
            self.minimumLineSpacing = 2
            self.minimumInteritemSpacing = 1
            self.collectionViewWidth = (collectionView?.bounds.width)!
            self.itemSize.width = (self.collectionViewWidth - 4)/3
            self.itemSize.height = self.itemHeight
    
            collectionView?.isScrollEnabled = false
            collectionView?.reloadData()
        }
    }
    
    
    override var collectionViewContentSize : CGSize {
        self.cellItemCount = (collectionView?.numberOfItems(inSection: 0))!
        self.collectionViewWidth = (collectionView?.frame.width)!
        //设置item的宽高显示比例防止变形
//        self.itemHeight = ((self.collectionViewWidth - 4)/3)*1.2
        self.collectionViewHeight = ((itemHeight + 2) * CGFloat(Int(cellItemCount-1)/3 + 1))

        if cellItemCount == 0 {
            return CGSize(width: self.collectionViewWidth, height: 0)
        }else{
            return CGSize(width: self.collectionViewWidth, height: self.collectionViewHeight)
        }
        collectionView?.reloadData()
        
    }
    
 

}

