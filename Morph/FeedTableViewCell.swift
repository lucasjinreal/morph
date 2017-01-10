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
    @IBOutlet weak var deviceModelLabel: UILabel!
    
    @IBOutlet weak var likecountLabel: UILabel!
    
    @IBOutlet weak var commentcountLabel: UILabel!
    @IBOutlet weak var postPicCollectionView: UICollectionView!

    @IBOutlet weak var postPicCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableviewcontentview: UIView!
    
    @IBOutlet weak var contenttextview: UITextView!
    var isLiked = false
    @IBOutlet weak var likeButton: UIButton!
    @IBAction func didTapLikeButton(_ sender: AnyObject) {
        if(isLiked){
            self.likeButton.setImage(UIImage(named: "icon_like_normal"), for: UIControlState())
            self.likecountLabel.text = String((self.status?.likecount)!)
            self.isLiked = false
        }else{
            self.likeButton.setImage(UIImage(named: "icon_like"), for: UIControlState())
            self.likecountLabel.text = String((self.status?.likecount)! + 1)
            self.isLiked = true
        }
    }
    
    @IBAction func didTapCommentButton(_ sender: AnyObject) {
        print("评论")
    }
    //从父viewcontroller里传过来
    var feedVC: FeedsViewController?
    var feedDetailVC: FeedsDetailViewController?
    var status: Status?{
        didSet{
            if status != nil{
                setupUI()
            }
           }
    }
 
    override func awakeFromNib() {
        super.awakeFromNib()
        self.avatar.layer.cornerRadius = self.avatar.frame.width/2
        self.avatar.layer.borderWidth = 2
        self.avatar.layer.borderColor = UIColor.white.cgColor
        self.avatar.layer.masksToBounds = true
        
        self.postPicCollectionView.delegate = self
        self.postPicCollectionView.dataSource = self
        self.postPicCollectionView.reloadData()
        
    }

  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupUI(){
        let flowLayout = PostPicCollectionViewFlowLayout()
        self.postPicCollectionView.collectionViewLayout = flowLayout
        self.postPicCollectionViewHeight.constant = self.postPicCollectionView.collectionViewLayout.collectionViewContentSize.height
        self.avatar.image = UIImage(named: (status?.avatar_url)!)
        self.namelabel.text = self.status?.name
        self.signlabel.text = self.status?.discribe
        self.contenttextview.text = self.status?.content
        self.timelabel.text = self.status?.time
        let devicemodel = self.status?.devicemodel
        self.deviceModelLabel.text = devicemodel
        self.likecountLabel.text = String((self.status?.likecount)!)
        self.commentcountLabel.text = String((self.status?.commentcount)!)
    }

}

extension FeedTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //在这里要判断一下发表的图片是否为0，否则会报错
        if(self.status?.pictures != nil){
            return (self.status?.pictures?.count)!
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.postPicCollectionView.dequeueReusableCell(withReuseIdentifier: "PostPicCell", for: indexPath) as! PostPicCollectionViewCell
        cell.postPic.image = self.status?.pictures![indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //如果feedVC为nil说明父VC是feeddetail，如果不为nil说明父VC为feedvc
        if self.feedVC == nil {
            let sb = UIStoryboard.init(name: "Home", bundle: Bundle.main)
            let imagePreviewVC = sb.instantiateViewController(withIdentifier: "ImagePreviewViewController") as! ImagePreviewViewController
            imagePreviewVC.previewImages = (self.status?.pictures)!
            imagePreviewVC.selectIndexPath = indexPath.row
            feedDetailVC!.present(imagePreviewVC,
                                          animated: true, completion: nil)

        }else{
            let sb = UIStoryboard.init(name: "Home", bundle: Bundle.main)
            let imagePreviewVC = sb.instantiateViewController(withIdentifier: "ImagePreviewViewController") as! ImagePreviewViewController
            imagePreviewVC.selectIndexPath = indexPath.row
            imagePreviewVC.previewImages = (self.status?.pictures)!
            feedVC!.present(imagePreviewVC,
                                          animated: true, completion: nil)

        }
    }
    
}

