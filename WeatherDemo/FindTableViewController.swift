//
//  FindTableViewController.swift
//  Morph
//
//  Created by JinTian on 4/26/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit
import LTMorphingLabel

class FindTableViewController: UITableViewController, LTMorphingLabelDelegate {
   

    @IBOutlet weak var mytumb: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor(red: 244/255.0, green: 40/255.0, blue: 69/255.0, alpha: 1)
        mytumb.layer.masksToBounds = true
        mytumb.layer.cornerRadius = 40
        mytumb.layer.borderWidth = 2
        mytumb.layer.borderColor = (UIColor.grayColor()).CGColor
        
        
        
    }
    
      
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func scrollViewDidScroll(scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        let prelude: CGFloat = 50
//        
//        if offsetY <= 64 {
//            let alpha = min(1, (64 - offsetY) / (64 + prelude))
//            //NavBar透明度渐变
//            self.navigationController?.navigationBar.alpha = 1 - alpha
//        } else {
//            self.navigationController?.navigationBar.alpha = 1
//        }
//    }

    
    
}
