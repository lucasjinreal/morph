//
//  AboutViewController.swift
//  Morph
//
//  Created by JinTian on 8/6/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit
import Spring

class AboutViewController: UIViewController {

  
    @IBOutlet weak var morphlabel: SpringLabel!
    @IBAction func didTapClose(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func didTapJoinUs(_ sender: AnyObject) {
        UIPasteboard.general.string = "516057916"
    }
    
      override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
