//
//  SettingTableViewController.swift
//  Morph
//
//  Created by JinTian on 8/9/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {

    
    @IBOutlet weak var cooperation: UITableViewCell!
    @IBOutlet weak var followus: UITableViewCell!
    @IBOutlet weak var qqgroup: UITableViewCell!
    
    @IBOutlet var settingtableview: UITableView!
    @IBOutlet weak var loginoutcell: UITableViewCell!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if loginoutcell.isSelected == true{
            
            let alert = UIAlertController(title: "确定退出Morph吗?", message: "", preferredStyle: .actionSheet)
            let action1 = UIAlertAction(title: "退出", style: .destructive, handler: { (action) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginvc = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                self.present(loginvc, animated: true, completion: nil)
                UserDefaults.standard.set(false, forKey: "haslogin")
            })
            let action2 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alert.addAction(action1)
            alert.addAction(action2)
            self.present(alert, animated: true, completion: nil)
        }else if self.cooperation.isSelected == true{
            UIPasteboard.general.string = "jintianiloveu"
            let alert = UIAlertController(title: "微信号已复制", message: "前往微信添加吧~", preferredStyle: .alert)
            let action = UIAlertAction(title: "确定", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }else if self.followus.isSelected == true{
            let alert2 = UIAlertController(title: "公众号已复制", message: "关注有惊喜哦", preferredStyle: .alert)
            let action2 = UIAlertAction(title: "确定", style: .default, handler: nil)
            alert2.addAction(action2)
            self.present(alert2, animated: true, completion: nil)
            
        }else if self.qqgroup.isSelected == true{
            let alert3 = UIAlertController(title: "群号已复制", message: "赶快加入吐槽千人大群", preferredStyle: .alert)
            let action3 = UIAlertAction(title: "确定", style: .default, handler: nil)
            alert3.addAction(action3)
            self.present(alert3, animated: true, completion: nil)
        }

        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}
