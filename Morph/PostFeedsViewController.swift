//
//  PostFeedsViewController.swift
//  Morph
//
//  Created by JinTian on 7/15/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

protocol PassPostStatusDelegate {
    func passPostStatus(_ postStatus: Status?)
}
class PostFeedsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    var sendStatus = [Status]()
    var posttext: String?
    var posttime: String?
//    var selectedPics: NSMutableArray?
    
    var placeholdertext = "说点什么吧~"
    var selectedImages: [UIImage?]?

    @IBOutlet weak var selectedCollectionView: UICollectionView!
    @IBOutlet weak var textviewpost: UITextView!
    @IBOutlet weak var visualeffectview: UIVisualEffectView!
    var passPostStatusDelegate: PassPostStatusDelegate?
    
    var postStatus: Status?
    
    @IBAction func didTapPost(_ sender: AnyObject) {
        self.getPostTime()
        let currentdevicename = UIDevice.current.name
//        for item in self.selectedPics!{
//            let image = item as! UIImage
//            selectedImages?.append(image)
//        }
//        self.selectedImages = NSArray(array: self.selectedPics, copyItems: true) as! Array<UIImage?>
        self.postStatus = Status(avatar_url: "f_6", name: "Alina", discribe: "一个机智阳光的小女孩", content: self.posttext, time: self.posttime, pictures: selectedImages, devicemodel: currentdevicename, commentcount: 0, likecount: 0)
        if self.passPostStatusDelegate != nil {
            self.passPostStatusDelegate?.passPostStatus(self.postStatus)
        }
        self.dismiss(animated: true, completion: nil)
    }
    func getPostTime(){
        let now = Date()
        let timeInterval:TimeInterval = now.timeIntervalSince1970
        //将时间戳赋值给posttime,这样可以保存所有信息，拿到之后在进行解析处理
        self.posttime = String(timeInterval)
    }
    
    @IBAction func didTapClose(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        //设置毛玻璃背景
        let blureffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        self.visualeffectview.effect = blureffect
        
        //设置placeholdertextview代理
        self.textviewpost.delegate = self
        self.textviewpost.text = placeholdertext
        self.textviewpost.textColor = UIColor.lightGray
        //设置collectionview的代理方法
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 2
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.itemSize.width = (self.selectedCollectionView.bounds.width - 6)/4
        flowLayout.itemSize.height = (self.selectedCollectionView.bounds.width - 6)/4
        self.selectedCollectionView.collectionViewLayout = flowLayout
        self.selectedCollectionView.dataSource = self
        self.selectedCollectionView.delegate = self
        self.selectedCollectionView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.selectedCollectionView.reloadData()
    }
    
}

extension PostFeedsViewController: UITextViewDelegate{
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.textviewpost.textColor = UIColor.blue
        if self.textviewpost.text == placeholdertext{
            self.textviewpost.text = ""
        }
        
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if self.textviewpost.text == ""{
            self.textviewpost.text = placeholdertext
            self.textviewpost.textColor = UIColor.lightGray
        }
        self.posttext = self.textviewpost.text
        debugPrint(self.posttext)
    }
}
extension PostFeedsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(self.selectedImages == nil){
            return 1
        }else{
            return (self.selectedImages?.count)! + 1
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.selectedCollectionView.dequeueReusableCell(withReuseIdentifier: "SelectedCell", for: indexPath)
        if self.selectedImages == nil {
            (cell.viewWithTag(104) as! UIImageView).image = UIImage(named: "icon_add")
            return cell
        }else{
            //由于之前返回cell个数为选择的个数+1，所以这里要判断在index小于选择个数时才显示array中的图片
            if (indexPath.row >= 0 && indexPath.row < (self.selectedImages?.count)!) {
                (cell.viewWithTag(104) as! UIImageView).image = self.selectedImages![indexPath.row]
                (cell.viewWithTag(104) as! UIImageView).contentMode = .scaleAspectFill
                return cell
                
            }else{
                (cell.viewWithTag(104) as! UIImageView).image = UIImage(named: "icon_add")
                (cell.viewWithTag(104) as! UIImageView).contentMode = .center
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemCount = self.selectedCollectionView.numberOfItems(inSection: 0)
        if indexPath.row == itemCount - 1 {
            let sb = UIStoryboard.init(name: "Home", bundle: Bundle.main)
            let selectPhotoVC = sb.instantiateViewController(withIdentifier: "SelectPhotoViewController") as! SelectPhotoViewController
            selectPhotoVC.postFeedsVC = self
            let navigationController = UINavigationController(rootViewController: selectPhotoVC)
            self.present(navigationController, animated: true, completion: nil)
        }else{
            let cell = collectionView.cellForItem(at: indexPath)
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: [], animations: {
                cell?.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
                cell?.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: nil)

        }
    }
}


