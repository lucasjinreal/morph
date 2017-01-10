//
//  DarenViewController.swift
//  Morph
//
//  Created by JinTian on 6/2/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit
import IQKeyboardManager

class DarenViewController: UIViewController {

   
   
    @IBOutlet weak var rootview: UIView!
    @IBOutlet var scrollview: UIScrollView!
    @IBOutlet weak var welcomemorphinglabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
  
        IQKeyboardManager.shared().isEnabled = true
        self.navigationController?.navigationItem.backBarButtonItem?.title = "返回"
        
        self.welcomemorphinglabel.numberOfLines = 0
        self.welcomemorphinglabel.text = "欢迎使用Morph众帮"
        let time: TimeInterval = 3
        let delay = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delay) {
            self.welcomemorphinglabel.text = "囊括天下奇才, 各路英雄豪杰"
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2 * time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
            self.welcomemorphinglabel.text = "一起来探索Morph众帮的神奇力量"
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        self.scrollview.contentSize = CGSize(width: CGFloat(self.view.bounds.width), height: CGFloat(700))
        

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}
