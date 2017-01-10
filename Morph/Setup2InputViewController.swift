//
//  Setup2InputViewController.swift
//  Morph
//
//  Created by JinTian on 4/15/16.
//  Copyright © 2016 JinTian. All rights reserved.
//
import UIKit
import SwiftForms


class Setup2InputViewController: UIViewController {
    
       override func viewDidLoad() {
        super.viewDidLoad()
        let rightitem=UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = rightitem
        self.navigationItem.title = "Name"

        
    }
         override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}
