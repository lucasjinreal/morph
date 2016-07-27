//
//  FeedTableViewCell.swift
//  Morph
//
//  Created by JinTian on 7/17/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit
import JTSImageViewController

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var signlabel: UILabel!
    @IBOutlet weak var timelabel: UILabel!
    
    @IBOutlet weak var buttonfavor: UIButton!
    @IBOutlet weak var buttonzan: UIButton!

    @IBOutlet weak var tableviewcontentview: UIView!
    @IBOutlet weak var imagepostheightconstraint: NSLayoutConstraint!
    @IBOutlet weak var contenttextview: UITextView!
    @IBOutlet weak var postimage: UIImageView!
    
    var status: Status?{
        didSet{
            if status != nil{
                setupUI()
            }
           }
    }
    override func awakeFromNib() {
        super.awakeFromNib()

               //设置头像
        self.avatar.layer.cornerRadius = self.avatar.frame.width/2
        self.avatar.layer.borderWidth = 2
        self.avatar.layer.borderColor = UIColor.whiteColor().CGColor
        self.avatar.layer.masksToBounds = true
        
        
        self.buttonfavor.addTarget(self, action: #selector(FeedTableViewCell.TapFavorButton(_:)), forControlEvents: .TouchDown)
        self.buttonzan.addTarget(self, action: #selector(FeedTableViewCell.TapZanButton(_:)), forControlEvents: .TouchDown)
        
        //为图片添加点击放大预览手势监听
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FeedTableViewCell.TapPostImage(_:)))
        self.postimage.userInteractionEnabled = true
        self.postimage.addGestureRecognizer(tapGestureRecognizer)

        
       

        
    }
    
    //点击图片放大预览代码
    func TapPostImage(sender: UITapGestureRecognizer){
        let imageinfo = JTSImageInfo()
        
        imageinfo.image = self.postimage.image
        imageinfo.referenceRect = self.postimage.frame
        imageinfo.referenceView = self.postimage.superview
        let imageViewer = JTSImageViewController(imageInfo: imageinfo, mode: .Image, backgroundStyle: .Blurred)
        imageViewer.showFromViewController(self.postimage.superview?.viewController(), transition: .FromOffscreen)
        
    }
    
    
   
    //点赞效果动画以及要执行的动作
    func TapFavorButton(sender: UIButton){
        self.buttonfavor.setBackgroundImage(UIImage(named: "heart-selected"), forState: .Normal)
        UIView.animateWithDuration(1.2, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.1, options: [], animations: {
            self.buttonfavor.transform = CGAffineTransformMakeScale(0.4, 0.4)
            self.buttonfavor.transform = CGAffineTransformMakeScale(3, 3)
            self.buttonfavor.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: nil)
    }
    
    func TapZanButton(sender: UIButton){
        self.buttonzan.setBackgroundImage(UIImage(named: "thumbs-up-selected"), forState: .Normal)
        UIView.animateWithDuration(1.2, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.1, options: [], animations: {
            self.buttonzan.transform = CGAffineTransformMakeScale(0.4, 0.4)
            self.buttonzan.transform = CGAffineTransformMakeScale(3, 3)
            self.buttonzan.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: nil)

        
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(){
        avatar.image = UIImage(named: (status?.avatar_url)!)
        namelabel.text = status?.name
        signlabel.text = status?.sign
        contenttextview.text = status?.content
        timelabel.text = status?.time
        if status?.picture_url == nil{
            //postimage.frame.size = CGSize(width: 0, height: 0)
            //postimage.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            imagepostheightconstraint.constant = 0
           
           
        }else{
            postimage.image = (status?.picture_url)!
            
        }
        

    }

}
