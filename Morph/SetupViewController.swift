//
//  SetupViewController.swift
//  Morph
//
//  Created by JinTian on 4/10/16.
//  Copyright © 2016 JinTian. All rights reserved.
//
import UIKit

class SetupViewController: UIViewController{

    fileprivate var i = -1
    fileprivate var textArray = [
        "在morph寻找好友",
        "发布您的需求",
        "甚至找到异性约会伙伴",
        "年轻的旅途从此刻开始.."
    ]
    fileprivate var text: String {
        i = i >= textArray.count - 1 ? 0 : i + 1
        return textArray[i]
    }
    var displayCount: Int = 0

    
    @IBOutlet weak var displaybutton: UIButton!
    @IBAction func closepress(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var label: UILabel!
    @IBAction func changeText(_ sender: AnyObject) {
        if self.displayCount < self.textArray.count{
            self.label.text = self.textArray[displayCount]
        }else{
            self.displaybutton.setTitle("点击下一步", for: UIControlState())
        }
        self.displayCount = self.displayCount + 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let item = UIBarButtonItem(title: " ", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
        label.text = "第一次登录，请先注册"
        
        self.displaybutton.layer.cornerRadius = 8
        UIView.animate(withDuration: 2, delay: 0, options: [], animations: {
            self.displaybutton.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
            self.displaybutton.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent;
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
