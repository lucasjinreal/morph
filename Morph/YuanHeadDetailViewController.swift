//
//  YuanHeadDetailViewController.swift
//  Morph
//
//  Created by JinTian on 5/15/16.
//  Copyright © 2016 JinTian. All rights reserved.
//


import UIKit

class YuanHeadDetailViewController: UIViewController {

   
    
    
    @IBOutlet weak var titlelabel: UILabel!
    @IBAction func takeinbutton(_ sender: AnyObject) {
        
    }
        override func viewDidLoad() {
        super.viewDidLoad()
        titlelabel.text = "大妈你好"
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}
