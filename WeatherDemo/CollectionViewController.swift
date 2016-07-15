//
//  CollectionViewController.swift
//  WeatherDemo
//
//  Created by JinTian on 3/27/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = UIColor.whiteColor()
    }
    
    // CollectionView行数
    override func collectionView(collectionView: UICollectionView,numberOfItemsInSection section: Int) -> Int {
        return courses.count
    }
    // 获取单元格
    override func collectionView(collectionView: UICollectionView,
                                 cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}