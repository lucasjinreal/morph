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
    var avatar = ["f_4", "f_5", "f_6", "f_7", "f_8", "f_9", "f_10"]
    var name = ["Jane Sally", "King Author", "William", "Elisabeth", "Jake", "Bell", "Roger"]
    var text = ["I love you for my life past.", "Sometimes,you just have to pretend that you are happy", "Nothing can't be figured out.", "Sometimes there is no way out exlept to say goodbye.", "I don't mind if you heat me.It doesn't matter at all.", "Don't surrender to this dark woeld.", "Plan the worst scnario with the best hope.", "Bing single means that you are strong enough and patient "]
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
        return avatar.count
    }
  
   
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = self.tableview.dequeueReusableCellWithIdentifier("chatlistcell", forIndexPath: indexPath) as! ChatlistTableViewCell
        
        cell.portrait.image = UIImage(named: avatar[indexPath.row])
        cell.portrait.layer.cornerRadius = cell.portrait.frame.size.width/2
        cell.portrait.clipsToBounds = true
        cell.portrait.layer.borderWidth = 1.5
        cell.portrait.layer.borderColor = UIColor.lightGrayColor().CGColor
        cell.username.text = name[indexPath.row]
        cell.chatcontent.text = text[indexPath.row]
        cell.time.text = "8:00 AM"
        
        return cell
    }
    
    //Mark-UITableView Delet
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if editingStyle == UITableViewCellEditingStyle.Delete{
            avatar.removeAtIndex(indexPath.row)
            name.removeAtIndex(indexPath.row)
            text.removeAtIndex(indexPath.row)
            self.tableview.deleteRowsAtIndexPaths([indexPath], withRowAnimation:UITableViewRowAnimation.Middle)
        }
    }

    //Mark-Did Select
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.tableview.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier("toconversation", sender: self)
        
        
    }



}
