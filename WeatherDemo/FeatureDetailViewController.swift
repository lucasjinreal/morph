//
//  FeatureDetailViewController.swift
//  Morph
//
//  Created by JinTian on 6/2/16.
//  Copyright © 2016 JinTian. All rights reserved.
//
import UIKit

class FeatureDetailViewController: UIViewController {

   
    
    @IBOutlet weak var tatumb: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var hibutton: UIButton!
    var picid:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.name.text = picid
        
        self.tatumb.layer.cornerRadius = self.tatumb.frame.width/2
        self.tatumb.layer.borderWidth = 2
        self.tatumb.layer.borderColor = UIColor.whiteColor().CGColor
        self.tatumb.image = UIImage(named: picid)
        
        self.hibutton.layer.borderWidth = 0.5
        self.hibutton.layer.borderColor = UIColor.redColor().CGColor
        self.hibutton.layer.cornerRadius = self.hibutton.frame.height/2
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}
