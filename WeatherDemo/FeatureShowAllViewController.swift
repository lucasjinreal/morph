//
//  FeatureShowAllViewController.swift
//  Morph
//
//  Created by JinTian on 6/4/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class FeatureShowAllViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

   
    
    
    @IBOutlet weak var showalltableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showalltableview.delegate = self
        self.showalltableview.dataSource = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}

extension FeatureShowAllViewController{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 8
    }
   
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = self.showalltableview.dequeueReusableCellWithIdentifier("featureshowallcell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = "测试"
        return cell
    }

}
