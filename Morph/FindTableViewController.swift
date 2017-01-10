//
//  FindTableViewController.swift
//  Morph
//
//  Created by JinTian on 4/26/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit
import Spring

class FindTableViewController: UITableViewController{
   

    @IBOutlet var findtableview: UITableView!
    @IBOutlet weak var mytumb: UIButton!
    
    @IBOutlet weak var nameLabel: SpringLabel!
    @IBOutlet weak var discribeLabel: SpringLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = UIColor(red: 244/255.0, green: 40/255.0, blue: 69/255.0, alpha: 1)
        
        
        mytumb.layer.masksToBounds = true
        mytumb.layer.cornerRadius = self.mytumb.frame.height/2
        mytumb.layer.borderWidth = 2
        mytumb.layer.borderColor = (UIColor.white).cgColor
        mytumb.layer.shadowColor = UIColor.black.cgColor
        mytumb.layer.shadowOffset = CGSize(width: 2, height: 2)
        mytumb.layer.shadowOpacity = 0.8
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.barStyle = .default

    }
    override func viewWillAppear(_ animated: Bool) {
        if let userData = UserDefaults.standard.object(forKey: "userinfo") as? Data{
            if let userinfo = NSKeyedUnarchiver.unarchiveObject(with: userData) as? UserInfo{
                let imageData = userinfo.portrait
                let image = UIImage(data: imageData! as Data)
                self.mytumb.setBackgroundImage(image, for: UIControlState())
                self.nameLabel.text = userinfo.uname as? String
                if(userinfo.discribe == nil){
                    self.discribeLabel.text = "站在风口的瞭望者"
                }else{
                    print(userinfo.discribe)
                    self.discribeLabel.text = userinfo.discribe as? String
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
    
}
