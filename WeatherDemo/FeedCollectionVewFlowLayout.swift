//
//  FeedCollectionVewFlowLayout.swift
//  Morph
//
//  Created by JinTian on 7/18/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class FeedCollectionVewFlowLayout: UICollectionViewFlowLayout {
    
    let mMinimumLineSpacing: CGFloat = 2
    let mMinimumInteritemSpacing: CGFloat = 10
    let mViewSizeWidth: CGFloat = 80
    let mViewSizeHeight: CGFloat = 80
    
    override init() {
        super.init()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /**
     This method sets up various properties of the horizontal collection view
     */
    override func prepareLayout() {
        if let collectionView = self.collectionView {
            collectionView.pagingEnabled = false
            self.minimumLineSpacing = self.mMinimumLineSpacing
            self.minimumInteritemSpacing = self.mMinimumInteritemSpacing
            self.scrollDirection = .Vertical
            self.itemSize = CGSizeMake(self.mViewSizeWidth, self.mViewSizeHeight)
            
            collectionView.contentInset = UIEdgeInsetsMake(1, 1, 1, 1)
            
        }
    }
    
    var isHeightCalculated: Bool = false
    
    func preferredLayoutAttributesFittingAttributes(layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        //Exhibit A - We need to cache our calculation to prevent a crash.
        if !isHeightCalculated {
            //setNeedsLayout()
            //layoutIfNeeded()
            let size = self.collectionView?.contentSize
            var newFrame = layoutAttributes.frame
            newFrame.size.width = CGFloat(ceilf(Float(size!.width)))
            layoutAttributes.frame = newFrame
            isHeightCalculated = true
        }
        return layoutAttributes
    }
    
       

}
