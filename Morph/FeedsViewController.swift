//
//  FeedsViewController.swift
//  WeatherDemo
//
//  Created by JinTian on 3/29/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit
import Alamofire
import JTSImageViewController
import Spring




class FeedsViewController: UIViewController, PassPostStatusDelegate{

    var updateAllStatus: [Status] = []
    var postStatus: Status?
    
    @IBAction func didTapBack(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
        debugPrint("退出了校园朋友圈")
    }
    @IBOutlet weak var homeavatar: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var discribeLabel: SpringLabel!
    @IBOutlet weak var tableview: UITableView!

    @IBOutlet weak var homebackground: UIImageView!
    
    @IBAction func didTapPost(_ sender: AnyObject) {
        let sb = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        let postVC = sb.instantiateViewController(withIdentifier: "PostFeedsViewController") as! PostFeedsViewController
        postVC.passPostStatusDelegate = self
        self.present(postVC, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        //self.loadTestData()
        //初始化个人用户信息
        if let bkImageData = UserDefaults.standard.object(forKey: "feedBackground") as! Data?{
            let bkImage = UIImage(data: bkImageData)
            self.homebackground.image = bkImage
        }else{
            self.homebackground.image = UIImage(named: "feed_bk")
        }
        if let userData = UserDefaults.standard.object(forKey: "userinfo") as? Data{
            if let userinfo = NSKeyedUnarchiver.unarchiveObject(with: userData) as? UserInfo{
                self.nameLabel.text = userinfo.uname as? String
                self.discribeLabel.text = userinfo.discribe as? String
                let imageData = userinfo.portrait! as Data
                let image = UIImage(data: imageData)
                self.homeavatar.image = image
            }else{
                if let userinfo = NSKeyedUnarchiver.unarchiveObject(with: userData) as? UserInfo{
                    if userinfo.sex == "男" {
                        self.homeavatar.image = UIImage(named: "default_m")
                    }else{
                        self.homeavatar.image = UIImage(named: "default_f")
                    }
                }
            }
        }
        self.tableview.delegate = self
        self.tableview.dataSource = self
        //设置tableview自适应内容高度
        self.tableview.rowHeight = UITableViewAutomaticDimension
        self.tableview.estimatedRowHeight = 150
        self.tableview.reloadData()
        
        //设置头像
        self.homeavatar.layer.cornerRadius = self.homeavatar.frame.width/2
        self.homeavatar.layer.borderWidth = 2
        self.homeavatar.layer.borderColor = UIColor.white.cgColor
        
        
        //设置背景图像tap点击
        let homebackgroundTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(FeedsViewController.homebkTap))
        self.homebackground.isUserInteractionEnabled = true
        self.homebackground.addGestureRecognizer(homebackgroundTapRecognizer)
   
    }
    func loadTestData(){
        //加载测试数据
        let status_1 = Status(avatar_url: "f_2", name: "杨紫薇", discribe: "新一代牛逼青年",content: "这是一段长文本，老板今天又出去约泡了我只能在这里帮他测试app大家看看这个文字有没有超过约束呢", time: "4分钟前", pictures: nil, devicemodel: "iPhone 6s", commentcount: 11, likecount: 2)
        self.updateAllStatus.append(status_1)
        
        var picArray2:[UIImage?] = []
        picArray2.append(UIImage(named: "pic3")!)
        picArray2.append(UIImage(named: "pic5")!)
        picArray2.append(UIImage(named: "pic6")!)
        let status_2 = Status(avatar_url: "f_3", name: "王大锤", discribe: "小王",content: "万万没想到停牌了，大家要看的话我留种", time: "12分钟前", pictures: picArray2, devicemodel: "iPhone 7 Plus", commentcount: 1, likecount: 2)
        self.updateAllStatus.append(status_2)
        
        var picArray3:[UIImage?] = []
        picArray3.append(UIImage(named: "pic4")!)
        picArray3.append(UIImage(named: "pic2")!)
        let status_3 = Status(avatar_url: "f_6", name: "Melina", discribe: "一个普通网红",content: "这个app做的很不错，界面好漂亮，不知道这个公司的员工是不是也有完美主义和强迫症呢？", time: "30分钟前", pictures: picArray3, devicemodel: "Samsung S7 Edge", commentcount: 2, likecount: 3)
        self.updateAllStatus.append(status_3)
        
        var picArray4:[UIImage?] = []
        picArray4.append(UIImage(named: "pic1")!)
        picArray4.append(UIImage(named: "pic3")!)
        picArray4.append(UIImage(named: "pic7")!)
        picArray4.append(UIImage(named: "pic6")!)
        picArray4.append(UIImage(named: "pic2")!)
        let status_4 = Status(avatar_url: "f_5", name: "Shelly", discribe: "IT民工",content: "遇到了一个bug。", time: "42分钟前", pictures: picArray4, devicemodel: "iPhone 6", commentcount: 2, likecount: 2)
        self.updateAllStatus.append(status_4)
    }
    
    func loadData(){
        let feedAPI = "http://115.29.140.140/Morph/GetFCServlet"
        print("执行了")
        if let sid = UserDefaults.standard.value(forKey: "sid"){
            let params = [
                "sid": sid
            ]
            print("开始请求网络")
            Alamofire.request(feedAPI, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (r) in
                switch r.result{
                case .success:
                    print("正在获取朋友圈动态")
                    print(r.result.value ?? "none")
                    break
                case .failure:
                    print("Error!请求朋友圈失败")
                    break
                }
            })

        }
        
    }
    func passPostStatus(_ postStatus: Status?) {
        //代理传过来的值
        if postStatus != nil{
            self.postStatus = postStatus
            self.updateAllStatus.insert(self.postStatus!, at: 0)
        }
        self.tableview.reloadData()
    }

    //更换背景
    func homebkTap(_ sender: UITapGestureRecognizer){
        let alertcontroller_homebk = UIAlertController(title: "从相册选取一张图片作为校园Feed页面背景", message: "选取一张优美的图片", preferredStyle: .actionSheet)
        let action_homebk1 = UIAlertAction(title: "更换背景", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                imagePicker.sourceType = .savedPhotosAlbum
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        let action_homebk2 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertcontroller_homebk.addAction(action_homebk1)
        alertcontroller_homebk.addAction(action_homebk2)
        self.present(alertcontroller_homebk, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}

extension FeedsViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let imageViewHeight: CGFloat = 194
        var imageViewFrame = CGRect(x: 0, y: 0, width: scrollView.bounds.width, height: imageViewHeight)
        if scrollView.contentOffset.y < (imageViewFrame.width - UIScreen.main.bounds.width){
            self.homebackground.frame.origin.x = scrollView.contentOffset.y / 2
            self.homebackground.frame.origin.y = scrollView.contentOffset.y
            
            imageViewFrame.origin.y = scrollView.contentOffset.y
            imageViewFrame.origin.x = 0.5*scrollView.contentOffset.y/2
            imageViewFrame.size.height = -scrollView.contentOffset.y + imageViewFrame.height
            imageViewFrame.size.width = -0.5*scrollView.contentOffset.y + imageViewFrame.width
        }
        self.homebackground.frame = imageViewFrame

    }
}

extension FeedsViewController: UITableViewDelegate, UITableViewDataSource{
    
    //Mark-Return rows of UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return updateAllStatus.count
    }
    //Mark-Return the cell of tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = self.tableview.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedTableViewCell
        cell.status = updateAllStatus[indexPath.row]
        //这个代码很重要！之前一直失败是因为这里没有刷新cell内部的collectionview
        cell.postPicCollectionView.reloadData()
        //设置cell中的控制器，方便后面点击cellitem跳转
        cell.feedVC = self
        //为头像添加一个点击进入个人资料的手势监听
        let avatarTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FeedsViewController.showuser))
        cell.avatar.isUserInteractionEnabled = true
        cell.avatar.addGestureRecognizer(avatarTapGestureRecognizer)
        return cell
    }
    
    //Mark-Did Select
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        let feedsDetailVC = sb.instantiateViewController(withIdentifier: "FeedsDetailViewController") as! FeedsDetailViewController
        feedsDetailVC.from_status = self.updateAllStatus[indexPath.row]
        self.navigationController?.pushViewController(feedsDetailVC, animated: true)
        self.tableview.deselectRow(at: indexPath, animated: true)
    }
    
    func showuser(){
        debugPrint("show userjeght")
        self.performSegue(withIdentifier: "touserinfo", sender: self)
    }

    
}

extension FeedsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    //实现imagepicker代理方法
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
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
        //将image永久化保存
        let imageData = UIImageJPEGRepresentation(image, 0.8)! as Data
        UserDefaults.standard.set(imageData, forKey: "feedBackground")
        dismiss(animated: true, completion: nil)
        
        
    }
    func imagePickerCnotrollerDidConcel(_ picker: UIImagePickerController){
        self.dismiss(animated: true, completion: nil)
    }

}
