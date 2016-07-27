//
//  FeedsViewController.swift
//  WeatherDemo
//
//  Created by JinTian on 3/29/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import JTSImageViewController



class FeedsViewController: UIViewController{

    var status: [Status] = []
    var to_status: Status?
    
    @IBOutlet weak var homeavatar: UIImageView!
    @IBOutlet weak var tableview: UITableView!

    @IBOutlet weak var homebackground: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.rowHeight = UITableViewAutomaticDimension
        self.tableview.estimatedRowHeight = 100
        
        self.tableview.reloadData()
        //self.loadData()
        
       
        //加载测试数据
        let status_1 = Status(avatar_url: "f_2", name: "Mina", sign: "Stay foolish stay hungry",content: "Fire in the heart, fire in the sky, the sun just a smallish smudge resting on the horizon out beyond the reef that breaks the waves, fiery sun that waits for no one. I was little more than a child when my father explaine that the mongrel is stronger than the thoroughbred.", time: "4分钟前", picture_url: nil)
        self.status.append(status_1)
        let status_2 = Status(avatar_url: "f_3", name: "Shelly", sign: "又变美了,哎",content: "明天的飞机去香港, 祝我好运~.", time: "12分钟前", picture_url: UIImage(named: "pic11"))
        self.status.append(status_2)
        let status_3 = Status(avatar_url: "f_6", name: "Melina", sign: "一个普通网红",content: "听说今天药学校长来了女生寝室, 是真是假?", time: "30分钟前", picture_url: UIImage(named: "pic11"))
        self.status.append(status_3)
        let status_4 = Status(avatar_url: "f_5", name: "Shelly", sign: "Sexy and Brilliant",content: "只想拥有一个这样的男朋友.", time: "42分钟前", picture_url: UIImage(named: "pic11"))
        self.status.append(status_4)

        //设置头像
        self.homeavatar.layer.cornerRadius = self.homeavatar.frame.width/2
        self.homeavatar.layer.borderWidth = 2
        self.homeavatar.layer.borderColor = UIColor.whiteColor().CGColor
        
        //设置背景图像tap点击
        let homebackgroundTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(FeedsViewController.homebkTap))
        self.homebackground.userInteractionEnabled = true
        self.homebackground.addGestureRecognizer(homebackgroundTapRecognizer)
   
    }
    
    func homebkTap(sender: UITapGestureRecognizer){
        let alertcontroller_homebk = UIAlertController(title: "从相册选取一张图片作为校园Feed页面背景", message: "选取一张较宽的图片", preferredStyle: .ActionSheet)
        let action_homebk1 = UIAlertAction(title: "更换背景", style: .Default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.SavedPhotosAlbum){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .SavedPhotosAlbum
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
        let action_homebk2 = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        alertcontroller_homebk.addAction(action_homebk1)
        alertcontroller_homebk.addAction(action_homebk2)
        self.presentViewController(alertcontroller_homebk, animated: true, completion: nil)
    }
//    func loadData(){
//        Alamofire.request(.GET, apiurl).responseJSON { (response) in
//            let JSON = response.result.value
//            let json = JSON?.objectForKey("stories")
//            for i in 0..<json!.count!{
//                let title = json![i].objectForKey("title") as! String
//                var picurl:String?
//                let str = json?[i].objectForKey("images") as! NSArray
//                if str == ""{
//                    picurl = "empty"
//                    
//                }else{
//                    picurl = str[0] as? String
//                    
//                }
//                let id = json?[i].objectForKey("id")
//                let urlid = "https://daily.zhihu.com/story/" + String(id!)
//                //self.urlid.append(url)
//                self.feeds.append(FeedsModel(title: title, picurl: picurl!, urlid: urlid))
//            }
//            self.tableview.reloadData()
//        }
//    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    //Mark:Prepare for segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "topostvc"{
            let postvc = segue.destinationViewController as! PostFeedsViewController
            postvc.addSatus({ (status) in
                self.status.insert(status, atIndex: 0)
                self.tableview.reloadData()
            })
            
        }
        
        if segue.identifier == "tofeeddetail"{
            let feeddetailvc = segue.destinationViewController as! FeedsDetailViewController
            feeddetailvc.from_status = self.to_status
        }
        
        if segue.identifier == "touserinfo"{
            let userinfovc = segue.destinationViewController as! FeatureDetailViewController
            userinfovc.picid = "苏唯美"
        }
        
            
        
    }

    @IBAction func close(segue:UIStoryboardSegue){
         print("close")
    }

}

extension FeedsViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let imageViewHeight: CGFloat = 110
        var imageViewFrame = CGRect(x: -40, y: 0, width: scrollView.bounds.width + 80, height: imageViewHeight)
        if scrollView.contentOffset.y < imageViewHeight{
            imageViewFrame.origin.y = scrollView.contentOffset.y
            imageViewFrame.origin.x = -40 + scrollView.contentOffset.y/2
            imageViewFrame.size.height = -scrollView.contentOffset.y + imageViewHeight
            imageViewFrame.size.width = -scrollView.contentOffset.y + imageViewFrame.width
        }
        self.homebackground.frame = imageViewFrame

    }
}

extension FeedsViewController: UITableViewDelegate, UITableViewDataSource{
    
    //Mark-Return rows of UITableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return status.count
    }
    //Mark-Return the cell of tableview
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = self.tableview.dequeueReusableCellWithIdentifier("FeedCell", forIndexPath: indexPath) as! FeedTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.Blue
        cell.status = status[indexPath.row]
        
        //为头像添加一个点击进入个人资料的手势监听
        let avatarTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FeedsViewController.showuser))
        cell.avatar.userInteractionEnabled = true
        cell.avatar.addGestureRecognizer(avatarTapGestureRecognizer)
        
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
        return cell
    }
    
    //Mark-Did Select
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.to_status = status[indexPath.row]
        self.performSegueWithIdentifier("tofeeddetail", sender: to_status)
     
        self.tableview.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
   
    
    func showuser(){
        debugPrint("show userjeght")
        self.performSegueWithIdentifier("touserinfo", sender: self)
    }

    
}

extension FeedsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    //实现imagepicker代理方法
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        var image: UIImage!
        // 判断，图片是否允许修改
        if(picker.allowsEditing){
            //裁剪后图片
            image = info[UIImagePickerControllerEditedImage] as! UIImage
        }else{
            //原始图片
            image = info[UIImagePickerControllerOriginalImage] as! UIImage
            
        }
        self.homebackground.image = image
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    func imagePickerCnotrollerDidConcel(picker: UIImagePickerController){
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
