//
//  DateTableViewController.swift
//  Morph
//
//  Created by JinTian on 7/11/16.
//  Copyright © 2016 JinTian. All rights reserved.
//
import UIKit
import Spring

class DateTableViewController: UITableViewController{
    
    @IBOutlet weak var activitycell: UITableViewCell!
    
    @IBOutlet weak var placecell: UITableViewCell!
    
    @IBOutlet weak var timecell: UITableViewCell!
    

    @IBOutlet var datetableview: UITableView!
    @IBOutlet weak var bkimage: UIImageView!
    @IBOutlet weak var meavatar: SpringImageView!
    @IBOutlet weak var taavatar: SpringImageView!
    @IBAction func concelpress(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func didTapFaqi(_ sender: AnyObject) {
        
        self.performSegue(withIdentifier: "unwindtoyuan", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.taavatar.layer.cornerRadius = 35
        self.taavatar.layer.borderWidth = 2
        self.taavatar.layer.borderColor = UIColor.white.cgColor
        self.taavatar.clipsToBounds = true
        self.meavatar.layer.cornerRadius = 35
        self.meavatar.layer.borderWidth = 2
        self.meavatar.layer.borderColor = UIColor.white.cgColor
        self.meavatar.clipsToBounds = true

        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if let userData = UserDefaults.standard.object(forKey: "userinfo") as? Data{
            if let userinfo = NSKeyedUnarchiver.unarchiveObject(with: userData) as? UserInfo{
                let imageData = userinfo.portrait! as Data
                let image = UIImage(data: imageData)
                self.meavatar.image = image
            }else{
                if let userinfo = NSKeyedUnarchiver.unarchiveObject(with: userData) as? UserInfo{
                    if userinfo.sex == "男" {
                        self.meavatar.image = UIImage(named: "default_m")
                    }else{
                        self.meavatar.image = UIImage(named: "default_f")
                    }
                }
            }
        }

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(activitycell.isSelected == true){
          
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "todateactivity"){
            let dateactivityvc = segue.destination as! DateActivityTableViewController
            dateactivityvc.changeLabelText { (str) in
                if(str == ""){
                    self.activitycell.detailTextLabel?.text = "未选择事项"
                }else{
                    var b = str!
                    b.remove(at: b.characters.index(b.endIndex, offsetBy: -2))
                    self.activitycell.detailTextLabel?.text = b
                }
            }
        }
        if(segue.identifier == "todatetime"){
            let datetimevc = segue.destination as! DateTimeViewController
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
