//
//  NewsCarouselCollectionViewFlowLayout.swift
//  Morph
//
//  Created by JinTian on 07/12/2016.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class NewsCarouselCollectionViewFlowLayout: UICollectionViewFlowLayout {
    

    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func prepare() {
        super.prepare()
    }
    
    //下面两个方法是实现牛逼卡片立体效果的核心，还是很好看很酷炫的勒
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        //拿到rect里面cell的所有布局
        var tempArray = super.layoutAttributesForElements(in: rect)!
        var replaceArray = [UICollectionViewLayoutAttributes]()
        //改变每一个数组中的每一个布局
        for i in 0..<tempArray.count {
            let layoutAttri = tempArray[i]
            let distanceToCenter: CGFloat = fabs(layoutAttri.center.x - self.collectionView!.contentOffset.x - self.collectionView!.frame.width / 2)
            var scale: CGFloat = 0.5
            let w: CGFloat = (self.collectionView!.frame.size.width + self.itemSize.width) * 0.5
            if distanceToCenter >= w {
                scale = 0.8
            }
            else {
                scale = scale + (1 - distanceToCenter / w) * 0.5
            }
            //缩放
            let transformScale = CGAffineTransform(scaleX: scale, y: scale)
            layoutAttri.transform = transformScale
            replaceArray.append(layoutAttri)
        }
        return replaceArray
    }
    
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var rect = self.collectionView!.bounds
        rect.size.width = self.collectionView!.frame.size.width + self.itemSize.width
        rect.origin.x = proposedContentOffset.x - self.itemSize.width
        rect.origin.y = proposedContentOffset.y
        rect.origin = proposedContentOffset
        var attriArray = super.layoutAttributesForElements(in: rect)!
        var distance: CGFloat = 1000
        //距离中心点绝对值最近的距离 在左边是负
        var minDistance: CGFloat = 0.0
        for i in 0..<attriArray.count {
            let layoutAttri = attriArray[i]
            let attriDistance: CGFloat = layoutAttri.center.x - proposedContentOffset.x - self.collectionView!.frame.width / 2
            if fabs(attriDistance) < distance {
                distance = fabs(attriDistance)
                minDistance = attriDistance
            }
        }
        //替换希望的contentOffset
        var actualPoint = CGPoint(x: proposedContentOffset.x + minDistance, y: proposedContentOffset.y)
        //处理第一个 和 最后一个的contentOffset
        let minContentOffsetX: CGFloat = -floor(self.collectionView!.contentInset.left)
        let maxContentOffsetX: CGFloat = floor(self.collectionView!.contentSize.width - self.collectionView!.frame.width + self.collectionView!.contentInset.right)
        actualPoint = actualPoint.x < minContentOffsetX ? CGPoint(x: minContentOffsetX, y: actualPoint.y) : actualPoint
        actualPoint = actualPoint.x > maxContentOffsetX ? CGPoint(x: maxContentOffsetX, y: actualPoint.y) : actualPoint
        return actualPoint
    }
    
    //当边界发生改变时，是否应该刷新布局。如果YES则在边界变化（一般是scroll到其他地方）时，将重新计算需要的布局信息
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
