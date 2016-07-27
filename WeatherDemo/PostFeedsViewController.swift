//
//  PostFeedsViewController.swift
//  Morph
//
//  Created by JinTian on 7/15/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

typealias MyClosureAddStatus = (status: Status) -> Void
class PostFeedsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var myClosureAddStatus: MyClosureAddStatus?
    var sendStatus = [Status]()
    var posttext: String?
    var posttime: String?
    var postimage: UIImage?
    var placeholdertext = "吐个槽或者装一下逼..."

    @IBOutlet weak var labeladdpic: UIButton!
    @IBOutlet weak var imageviewpost: UIImageView!
    @IBOutlet weak var textviewpost: UITextView!
    @IBOutlet weak var visualeffectview: UIVisualEffectView!
    @IBAction func didTapPost(sender: AnyObject) {
        self.getNowTime()
        let poststatus = Status(avatar_url: "f_6", name: "Alina", sign: "一个机智阳光的小女孩", content: self.posttext, time: self.posttime, picture_url: self.postimage)
        debugPrint(self.postimage)
        self.myClosureAddStatus!(status: poststatus)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func getNowTime(){
        let now = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy MM dd HH:mm:ss"
        self.posttime = formatter.stringFromDate(now)

    }
    
    @IBAction func didTapClose(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func didTapAddPic(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.SavedPhotosAlbum){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .SavedPhotosAlbum
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        
    }
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
        self.imageviewpost.image = image
        self.postimage = image
        dismissViewControllerAnimated(true, completion: nil)
        self.labeladdpic.titleLabel?.text = ""
        
    }
    func imagePickerCnotrollerDidConcel(picker: UIImagePickerController){
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    //实现一个方法来实现代理
    func addSatus(closure: MyClosureAddStatus){
        myClosureAddStatus = closure
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clearColor()
        //设置毛玻璃背景
        let blureffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        self.visualeffectview.effect = blureffect
        
        //设置placeholdertextview代理
        self.textviewpost.delegate = self
        self.textviewpost.text = placeholdertext
        self.textviewpost.textColor = UIColor.lightGrayColor()
     
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PostFeedsViewController: UITextViewDelegate{
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        self.textviewpost.textColor = UIColor.orangeColor()
        if self.textviewpost.text == placeholdertext{
            self.textviewpost.text = ""
        }
        
        return true
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if self.textviewpost.text == ""{
            self.textviewpost.text = placeholdertext
            self.textviewpost.textColor = UIColor.lightGrayColor()
        }
        self.posttext = self.textviewpost.text
        debugPrint(self.posttext)
    }
}


