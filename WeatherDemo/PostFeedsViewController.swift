//
//  PostFeedsViewController.swift
//  Morph
//
//  Created by JinTian on 7/15/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class PostFeedsViewController: UIViewController {

   
    @IBAction func didTapConcel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.view.backgroundColor = UIColor.clearColor()
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
