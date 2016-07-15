//
//  ChatViewController.swift
//  Morph
//
//  Created by JinTian on 4/25/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
 
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        //self.tableview.registerNib(UINib(nibName: "FeedsTableViewCell", bundle: nil), forCellReuseIdentifier: "mycell")
        tableview.registerNib(UINib(nibName: "ChatlistTableViewCell", bundle: nil), forCellReuseIdentifier: "chatlistcell")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 5
    }
  
   
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = self.tableview.dequeueReusableCellWithIdentifier("chatlistcell", forIndexPath: indexPath) as! ChatlistTableViewCell
        
        cell.portrait.image = UIImage(named: "tumb2")
        cell.portrait.layer.cornerRadius = cell.portrait.frame.size.width/2
        cell.portrait.clipsToBounds = true
        cell.portrait.layer.borderWidth = 1.5
        cell.portrait.layer.borderColor = UIColor.lightGrayColor().CGColor
        cell.username.text = "习近平"
        cell.chatcontent.text = "今天晚上奥巴马邀请你去吃晚饭，你去吗？"
        cell.time.text = "8:00"
        
        return cell
    }
    
      //Mark-UITableView Delet
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if editingStyle == UITableViewCellEditingStyle.Delete{
            self.tableview.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Middle)

        }
    }
    //Mark-Did Select
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.tableview.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier("toconversation", sender: self)
        
        
    }



}
