//
//  NameInputTableViewController.swift
//  Morph
//
//  Created by JinTian on 4/16/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class NameInputTableViewController: UITableViewController, UITextFieldDelegate {

   
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var tableviewcell: UITableViewCell!
    var name:String?
    
    @IBOutlet var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameTextField.delegate  = self
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.alpha = 0.9
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor()]
        self.view.backgroundColor = UIColor.groupTableViewBackgroundColor()
        
        
    }
//    override func viewDidAppear(animated: Bool) {
//        
//        self.name = self.nameTextField.text!
//        debugPrint("这来自名字输入vc \(name)")
//
//    }
    
    @IBAction func doneInput(sender: AnyObject) {
//        name = nameTextField.text
        self.name = self.nameTextField.text
        debugPrint("这是第一个输出 \(name)")
        performSegueWithIdentifier("unwindtome", sender: sender)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}
