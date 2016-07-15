//
//  DateViewController.swift
//  Morph
//
//  Created by JinTian on 6/5/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {

   
    
    
    @IBOutlet weak var meavatar: UIImageView!
    @IBOutlet weak var taavatar: UIImageView!
    @IBAction func concelpress(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    @IBAction func didTapFaqi(sender: AnyObject) {
    
        self.performSegueWithIdentifier("unwindtoyuan", sender: sender)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.taavatar.layer.cornerRadius = 35
        self.taavatar.layer.borderWidth = 3
        self.taavatar.layer.borderColor = UIColor.whiteColor().CGColor
        self.taavatar.clipsToBounds = true
        self.meavatar.layer.cornerRadius = 35
        self.meavatar.layer.borderWidth = 3
        self.meavatar.layer.borderColor = UIColor.whiteColor().CGColor
        self.meavatar.clipsToBounds = true
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func close(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        let yuanvc = YuanViewController()
        //yuanvc.datebutton.titleLabel?.text = "约会进行中"
    }
  
}
