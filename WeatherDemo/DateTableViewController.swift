//
//  DateTableViewController.swift
//  Morph
//
//  Created by JinTian on 7/11/16.
//  Copyright © 2016 JinTian. All rights reserved.
//
import UIKit

class DateTableViewController: UITableViewController{
    
    @IBOutlet weak var activitycell: UITableViewCell!
    
    @IBOutlet weak var placecell: UITableViewCell!
    
    @IBOutlet weak var timecell: UITableViewCell!
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
   
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(activitycell.selected == true){
          
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "todateactivity"){
            let dateactivityvc = segue.destinationViewController as! DateActivityTableViewController
            dateactivityvc.changeLabelText { (str) in
                if(str == ""){
                    self.activitycell.detailTextLabel?.text = "未选择事项"
                }else{
                    var b = str!
                    b.removeAtIndex(b.endIndex.advancedBy(-2))
                    self.activitycell.detailTextLabel?.text = b
                }
            }
        }
        if(segue.identifier == "todatetime"){
            let datetimevc = segue.destinationViewController as! DateTimeViewController
            datetimevc.changetimetext({ (str) in
                if(str == "到"){
                    self.timecell.detailTextLabel?.text = "未选择时间段"
                }else{
                    let c = str
                    self.timecell.detailTextLabel?.text = c
                }
            })
        }
    }
    
}
