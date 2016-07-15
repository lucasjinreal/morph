//
//  FeedsViewController.swift
//  WeatherDemo
//
//  Created by JinTian on 3/29/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class FeedsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var feeds = [FeedsModel]()
    let apiurl = "https://news-at.zhihu.com/api/4/news/latest"
    var urlib = Array<String>()
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.registerNib(UINib(nibName: "FeedsTableViewCell", bundle: nil), forCellReuseIdentifier: "mycell")
        self.loadData()
        var itemimgleft = UIImage(named: "f_2")
        itemimgleft = itemimgleft?.imageWithRenderingMode(.AlwaysOriginal)
        let itembuttonleft = UIBarButtonItem(image: itemimgleft, style: .Plain, target: self, action: nil)
        
        //self.navigationItem.leftBarButtonItem = itembuttonleft

        


       
        
    }
    func loadData(){
        Alamofire.request(.GET, apiurl).responseJSON { (response) in
            let JSON = response.result.value
            let json = JSON?.objectForKey("stories")
            for i in 0..<json!.count!{
                let title = json![i].objectForKey("title") as! String
                var picurl:String?
                let str = json?[i].objectForKey("images") as! NSArray
                if str == ""{
                    picurl = "empty"
                    
                }else{
                    picurl = str[0] as? String
                    
                }
                let id = json?[i].objectForKey("id")
                let urlid = "https://daily.zhihu.com/story/" + String(id!)
                //self.urlid.append(url)
                self.feeds.append(FeedsModel(title: title, picurl: picurl!, urlid: urlid))
            }
            self.tableview.reloadData()
        }
    }
    
    
    //Mark-Return rows of UITableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return feeds.count
    }
    //Mark-Return the cell of tableview
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = self.tableview.dequeueReusableCellWithIdentifier("mycell", forIndexPath: indexPath) as! FeedsTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.Blue
        cell.labeltitle.text = self.feeds[indexPath.row].title
        let url = self.feeds[indexPath.row].picurl
        if url == "empty"{
            cell.pic.image = UIImage(named: "pic1")
        }else{
            dispatch_async(dispatch_get_global_queue(0, 0)){() -> Void in
                cell.pic.sd_setImageWithURL(NSURL(string: url))
                
            }
        }
        
        return cell
    }
    
    //Mark-UITableView Delet
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if editingStyle == UITableViewCellEditingStyle.Delete{
            feeds.removeAtIndex(indexPath.row)
            self.tableview.deleteRowsAtIndexPaths([indexPath], withRowAnimation:UITableViewRowAnimation.Middle)
        }
    }
    
    //Mark-Did Select
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.tableview.deselectRowAtIndexPath(indexPath, animated: true)
        let urlid = self.feeds[indexPath.row].urlid as String!
        self.performSegueWithIdentifier("todetail", sender: urlid)
        //self.performSegueWithIdentifier("todetail", sender: urlid)
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Mark:Prepare for segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "todetail"{
            let feedsdetailViewController =  segue.destinationViewController as! FeedsDetailViewController
            feedsdetailViewController.urlid = sender as! String
        }
    }

    @IBAction func close(segue:UIStoryboardSegue){
         print("close")
    }

}
