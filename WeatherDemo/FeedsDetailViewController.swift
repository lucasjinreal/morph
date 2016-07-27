//
//  FeedsDetailViewController.swift
//  Morph
//
//  Created by JinTian on 7/17/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class FeedsDetailViewController: UIViewController {
    
    @IBOutlet weak var feeddetailtableview: UITableView!
    
  
    
    var from_status: Status?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.translucent = false
//        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 64)
//        self.navigationController?.navigationBar.barStyle = .Default
        //记得设置tableview的代理和数据源
        self.feeddetailtableview.dataSource = self
        self.feeddetailtableview.delegate = self
        self.feeddetailtableview.rowHeight = UITableViewAutomaticDimension
        self.feeddetailtableview.estimatedRowHeight = 100
        
        self.feeddetailtableview.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

}

extension FeedsDetailViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }
   
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = self.feeddetailtableview.dequeueReusableCellWithIdentifier("feeddetailcell") as! FeedTableViewCell
        cell.status = from_status!
        return cell
       
    }
 

}
