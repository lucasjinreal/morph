//
//  YuanViewController.swift
//  Morph
//
//  Created by JinTian on 5/10/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

import UIKit

class YuanViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
 
    @IBOutlet weak var matchlabel: UILabel!
    @IBOutlet weak var bestmatchview: UIView!
    @IBOutlet weak var peoplesuggestview: UIView!
    @IBOutlet weak var imageme: UIImageView!
    @IBOutlet weak var imageta: UIImageView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var headcollectionview: UICollectionView!
    @IBOutlet weak var featurecollectionview: UICollectionView!
    @IBOutlet weak var datebutton: UIButton!
    let pic = ["f_1", "f_2", "f_3", "f_4", "f_5", "f_1", "f_3", "f_4"]
    
    @IBAction func didTapDateButton(sender: AnyObject) {
        PopupController
        .create(self)
        .customize(
            [
                .Animation(.SlideUp),
                .Scrollable(false),
                .BackgroundStyle(.BlackFilter(alpha: 0.7))
            ]
        )
        .show(DatePopupViewController.instance())
    }
    
      override func viewDidLoad() {
        super.viewDidLoad()
        //把两个view圆角化
        self.peoplesuggestview.layer.cornerRadius = 8
        self.bestmatchview.layer.cornerRadius = 8
        
        
        headcollectionview.dataSource = self
        headcollectionview.delegate = self
        featurecollectionview.dataSource = self
        featurecollectionview.delegate = self
        
        
        headcollectionview.showsHorizontalScrollIndicator = false;
        let collectionPageViewLayout : YuanCollectionViewFlowLayout = YuanCollectionViewFlowLayout()
        headcollectionview.setCollectionViewLayout(collectionPageViewLayout, animated: false);
        
        headcollectionview.registerNib(UINib(nibName: "YuanCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "yuancollectioncell")
    
        //设置contentsize，不然滚动不起来这个scrollview
        scrollview.contentSize = CGSize(width: CGFloat(self.view.bounds.width), height: CGFloat(700))
        
        //对图像进行一个预先处理
        self.imageta.layer.cornerRadius = self.imageta.frame.width/2
        self.imageta.layer.masksToBounds = true
        self.imageme.layer.cornerRadius = self.imageme.frame.width/2
        self.imageme.layer.masksToBounds = true
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(segue: UIStoryboardSegue){
        self.datebutton.setTitle("等待对方回复中", forState: .Normal)
        self.datebutton.enabled = false
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "tota"{
            let featuredetailviewcontroller = segue.destinationViewController as! FeatureDetailViewController
            featuredetailviewcontroller.picid = sender as! String
        }
            
            
    }
    
}


extension YuanViewController{
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if collectionView.tag == 1002{
            return 1
        }else{
            return 1
        }
        
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if collectionView.tag == 1002{
            return 4
        }else{
            return 8
        }
        
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1002{
            let cell = headcollectionview.dequeueReusableCellWithReuseIdentifier("yuancollectioncell", forIndexPath: indexPath) as! YuanCollectionViewCell
            cell.picture.image = UIImage(named: "activity_bk1")
            return cell
        }else{
            let cell = featurecollectionview.dequeueReusableCellWithReuseIdentifier("featurecell", forIndexPath: indexPath)
            (cell.contentView.viewWithTag(1) as! UIImageView).image = UIImage(named: pic[indexPath.row])
            (cell.contentView.viewWithTag(1) as! UIImageView).layer.cornerRadius = (cell.contentView.viewWithTag(1) as! UIImageView).frame.width/2
            (cell.contentView.viewWithTag(1) as! UIImageView).layer.masksToBounds = true
            
            return cell
        }
        //return nil
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if collectionView.tag == 1000{
            let picid = self.pic[indexPath.row] as String
            self.performSegueWithIdentifier("tota", sender: picid)
            NSLog(picid)
        }else{
            
            self.performSegueWithIdentifier("toyuanheaddetail", sender: self)
        }
        
    }
  
        
}

