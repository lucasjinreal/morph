//
//  DateActivityTableViewController.swift
//  Morph
//
//  Created by JinTian on 7/11/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit


typealias MyClosure = (str: String?) -> Void
class DateActivityTableViewController: UITableViewController {
    
    var activity = ""
    var myClosure: MyClosure?

    
    @IBOutlet weak var cell1: UITableViewCell!
    @IBOutlet weak var cell2: UITableViewCell!
    @IBOutlet weak var cell3: UITableViewCell!
    @IBOutlet weak var cell4: UITableViewCell!
    @IBOutlet weak var cell5: UITableViewCell!
    @IBOutlet weak var cell6: UITableViewCell!
    @IBOutlet weak var cell7: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    func changeLabelText(closure: MyClosure){
        myClosure = closure
    }
 
    
    override func viewDidDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        myClosure!(str: self.activity)
       
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(cell1.selected == true){
            
            cell1.accessoryType = .Checkmark
            activity = activity + (self.cell1.textLabel?.text)! + ", "
        
        }else if(cell2.selected == true){
            
            cell2.accessoryType = .Checkmark
            activity = activity + (self.cell2.textLabel?.text)! + ", "
        }else if(cell3.selected == true){
            
            cell3.accessoryType = .Checkmark
            activity = activity + (self.cell3.textLabel?.text)! + ", "
        }else if(cell4.selected == true){
            
            cell4.accessoryType = .Checkmark
            activity = activity + (self.cell4.textLabel?.text)! + ", "
        }else if(cell5.selected == true){
            
            cell5.accessoryType = .Checkmark
            activity = activity + (self.cell5.textLabel?.text)! + ", "
        }else if(cell6.selected == true){
            
            cell6.accessoryType = .Checkmark
            activity = activity + (self.cell6.textLabel?.text)! + ", "
        }else if(cell7.selected == true){
            
            cell7.accessoryType = .Checkmark
            activity = activity + (self.cell7.textLabel?.text)! + ", "
        }
        
        cell1.setSelected(false, animated: true)
        cell2.setSelected(false, animated: true)
        cell3.setSelected(false, animated: true)
        cell4.setSelected(false, animated: true)
        cell5.setSelected(false, animated: true)
        cell6.setSelected(false, animated: true)
        cell7.setSelected(false, animated: true)
        
    }
    
}
