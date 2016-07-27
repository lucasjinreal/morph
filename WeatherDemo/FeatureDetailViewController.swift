//
//  FeatureDetailViewController.swift
//  Morph
//
//  Created by JinTian on 6/2/16.
//  Copyright © 2016 JinTian. All rights reserved.
//
import UIKit

class FeatureDetailViewController: UIViewController {

   
    
    @IBOutlet weak var boardview: UIView!
    @IBOutlet weak var backgroundimageview: UIImageView!
    @IBOutlet weak var albumcollectionview: UICollectionView!
  
    @IBOutlet weak var featurescrollview: UIScrollView!
    
    @IBOutlet weak var tatumb: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var hibutton: UIButton!
    var picid:String!
    
    @IBAction func didTapHiButton(sender: AnyObject) {
        let conversationvc = ConversationViewController()
        self.navigationController?.pushViewController(conversationvc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.name.text = picid
        
        self.tatumb.layer.cornerRadius = self.tatumb.frame.width/2
        self.tatumb.layer.borderWidth = 2
        self.tatumb.layer.borderColor = UIColor.whiteColor().CGColor
        self.tatumb.image = UIImage(named: picid)
        
        self.hibutton.layer.borderWidth = 0.5
        self.hibutton.layer.borderColor = UIColor.redColor().CGColor
        self.hibutton.layer.cornerRadius = self.hibutton.frame.height/2
        
        //创建毛玻璃效果背景
        let blureffect = UIBlurEffect(style: .Light)
        let featurevisualeffectview = UIVisualEffectView(effect: blureffect)
        featurevisualeffectview.frame = CGRect(origin: CGPointZero, size: UIScreen.mainScreen().bounds.size)
        self.backgroundimageview.addSubview(featurevisualeffectview)
        
        //设置scrollerview的滚动范围
        self.featurescrollview.contentSize = CGSize(width: CGFloat(self.view.bounds.width), height: CGFloat(700))
        self.albumcollectionview.dataSource = self
        self.albumcollectionview.delegate = self
        
        self.boardview.layer.cornerRadius = 5
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}

extension FeatureDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 9
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
       let cell = albumcollectionview.dequeueReusableCellWithReuseIdentifier("albumcell", forIndexPath: indexPath)
        (cell.contentView.viewWithTag(3001) as! UIImageView).image = UIImage(named: "pic11")
        
            return cell
    }
    
    
}
