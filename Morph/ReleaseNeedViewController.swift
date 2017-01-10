//
//  ReleaseNeedViewController.swift
//  Morph
//
//  Created by JinTian on 8/6/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class ReleaseNeedViewController: UIViewController {
    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    @IBOutlet weak var needtitlelabel: UITextField!
    @IBOutlet weak var releasebutton: UIButton!
    @IBOutlet weak var needdiscriptiontextview: UITextView!
    
    @IBOutlet weak var needlocationlabel: UITextField!
    
    @IBAction func didTapReleaseButton(_ sender: AnyObject) {
        
       self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapCancel(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func didTapMoreButton(_ sender: AnyObject) {
        let alert = UIAlertController(title: "选择酬谢方式", message: "表达一下你的谢意吧~", preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "送妹子", style: .default) { (action) in
            self.needmoneylabel.text = "送妹子"
        }
        let action2 = UIAlertAction(title: "请喝咖啡", style: .default) { (action) in
            self.needmoneylabel.text = "请喝咖啡"
        }
        let action3 = UIAlertAction(title: "陪自习一天", style: .default) { (action) in
            self.needmoneylabel.text = "陪自习一天"
        }
        let action4 = UIAlertAction(title: "请吃顿饭", style: .default) { (action) in
            self.needmoneylabel.text = "请吃顿饭"
        }
        let action5 = UIAlertAction(title: "教钢琴", style: .default) { (action) in
            self.needmoneylabel.text = "教钢琴"
        }
        let action6 = UIAlertAction(title: "教魔术", style: .default) { (action) in
            self.needmoneylabel.text = "教魔术"
        }
        let actioncancell = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(action1)
        alert.addAction(action2)
        alert.addAction(action3)
        alert.addAction(action4)
        alert.addAction(action5)
        alert.addAction(action6)
        alert.addAction(actioncancell)
        self.present(alert, animated: true, completion: nil)
        
    }
    @IBOutlet weak var needmoneylabel: UITextField!
    
    var placeholdertext = "请输入需求描述, 比如: 求一人帮我做海报, 魔术社的海报, 要求PS靠谱大神"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.needdiscriptiontextview.text = placeholdertext
        self.needdiscriptiontextview.textColor = UIColor.lightGray
        self.needdiscriptiontextview.delegate = self
        self.navigationController?.navigationItem.backBarButtonItem?.title = "返回"
        self.needtitlelabel.layer.cornerRadius = 5
        self.avatar.layer.cornerRadius = self.avatar.frame.width/2
        self.avatar.layer.borderWidth = 2
        self.avatar.layer.borderColor = UIColor.white.cgColor
        self.avatar.clipsToBounds = true
        self.view1.layer.cornerRadius = 10
        self.view2.layer.cornerRadius = 10
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        self.scrollview.contentSize = CGSize(width: CGFloat(self.view.bounds.width), height: CGFloat(700))
        
        
    }

    

}

extension ReleaseNeedViewController: UITextViewDelegate{
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.needdiscriptiontextview.textColor = UIColor.blue
        if self.needdiscriptiontextview.text == placeholdertext{
            self.needdiscriptiontextview.text = ""
        }
        
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if self.needdiscriptiontextview.text == ""{
            self.needdiscriptiontextview.text = placeholdertext
            self.needdiscriptiontextview.textColor = UIColor.lightGray
        }
        
    }
}
