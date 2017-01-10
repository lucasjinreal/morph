//
//  FeedsDetailViewController.swift
//  Morph
//
//  Created by JinTian on 7/17/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit
import IQKeyboardManager

class FeedsDetailViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var inputbarview: UIView!
    
    @IBOutlet weak var commenttableview: UITableView!
    @IBOutlet weak var commenttextview: UITextView!
    @IBAction func didTapSend(_ sender: AnyObject) {
        debugPrint("点击了表情")
    }
    let placeholdertext = " 评论点什么吧.."
    var from_status: Status?
    var comments: [CommentModal?] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置inputbarview blur效果
        let blureffect = UIBlurEffect(style: .light)
        let visualeffectview = UIVisualEffectView(effect: blureffect)
        self.inputbarview.addSubview(visualeffectview)
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        IQKeyboardManager.shared().isEnableAutoToolbar = false
        
        self.commenttableview.dataSource = self
        self.commenttableview.delegate = self
        self.commenttableview.rowHeight = UITableViewAutomaticDimension
        self.commenttableview.estimatedRowHeight = 80
        
        self.commenttextview.delegate = self
        self.commenttextview.layer.cornerRadius = 4
        self.commenttextview.text = placeholdertext
        self.commenttextview.textColor = UIColor.lightGray
        
        let comment1 = CommentModal(avatar: UIImage(named: "f_6"), username: "jintian", commentcontent: "你个菩萨大哥啊", commenttime: "12:51", replyarray: ["回复 jintiaen: 你死了吗", "没有死啊", "死了吧", "我曹你找到"])
        let comment2 = CommentModal(avatar: UIImage(named: "f_6"), username: "jintian", commentcontent: "你个菩萨大哥啊", commenttime: "12:51", replyarray: ["回复 James: 你死了吗", "回复jintian: 没有死啊", "我死了, 死了吧", "我曹你找到"])
        self.comments.insert(comment1, at: 0)
        self.comments.insert(comment2, at: 0)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.commenttableview.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(FeedsDetailViewController.keyBoardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(FeedsDetailViewController.keyBoardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    //实现监听键盘弹起的方法
    func keyBoardWillShow(_ notification: Notification){
        let userinfo = notification.userInfo! as NSDictionary
        //从userinfo中获取键盘的位置信息以及动画时间甚至曲线等
        let keyBoardBounds = (userinfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let duration = (userinfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        //将相对的键盘位置转换成相对于本view的位置
        
        let deltay = keyBoardBounds.size.height
        debugPrint("deltay", deltay)
        let animations: (() -> Void) = {
            self.inputbarview.transform = CGAffineTransform(translationX: 0, y: -deltay)}
        if duration > 0{
            let options = UIViewAnimationOptions(rawValue: UInt((userinfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
            UIView.animate(withDuration: duration, delay: 0, options: options, animations: animations, completion: nil)
        }else{
            animations()
        }
    }
    
    func keyBoardWillHide(_ notification: Notification){
        let userInfo  = notification.userInfo! as NSDictionary
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        
        let animations:(() -> Void) = {
            
            self.inputbarview.transform = CGAffineTransform.identity
            
        }
        
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
            
            UIView.animate(withDuration: duration, delay: 0, options:options, animations: animations, completion: nil)
        }else{
            animations()
        }
        
    }
}

extension FeedsDetailViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if section == 0 {
            return 1
        }else{
            return comments.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if indexPath.section == 0{
            let cell = self.commenttableview.dequeueReusableCell(withIdentifier: "FeedDetailCell") as! FeedTableViewCell
            cell.status = from_status
            cell.feedDetailVC = self
            return cell
        }else{
            let cell = self.commenttableview.dequeueReusableCell(withIdentifier: "commentcell") as! CommentTableViewCell
            cell.comment = comments[indexPath.row]
            
            return cell
            
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return nil
        }else{
            return "评论数: " + String(comments.count)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 5
        }else{
            return 20
        }
    }
    
}


extension FeedsDetailViewController: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            let comment2 = CommentModal(avatar: UIImage(named: "f_5"), username: "James", commentcontent: self.commenttextview.text, commenttime: "10:23", replyarray: ["回复 jintian: 你死了吗"])
            self.comments.insert(comment2, at: 0)
            self.commenttableview.reloadData()
            
            self.commenttextview.textColor = UIColor.lightGray
            self.commenttextview.text = placeholdertext
            self.commenttextview.resignFirstResponder()
            return false
        }
        
        return true
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.commenttextview.textColor = UIColor.darkGray
        if self.commenttextview.text == placeholdertext{
            self.commenttextview.text = ""
        }
        return true
    }
    
}
