//
//  FindResultTableViewController.swift
//  Morph
//
//  Created by JinTian on 07/12/2016.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit
import Alamofire

class FindResultTableViewController: UITableViewController {

    var sid: String?
    var resultUser: [PeopleModal]?
    
    
    @IBOutlet var resultTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.resultTableView.dataSource = self
        self.resultTableView.delegate = self
        print(self.resultUser)
        
        
       
    }

    
    override func viewWillAppear(_ animated: Bool) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.resultUser != nil{
            return (self.resultUser?.count)!
        }else{
            let noDataBackgroundLabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            noDataBackgroundLabel.text = "然而并没有该用户"
            self.resultTableView.separatorStyle = .none
            self.resultTableView.backgroundColor = UIColor.clear
            self.resultTableView.backgroundView = noDataBackgroundLabel
            return 0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.resultTableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        (cell.viewWithTag(20) as! UIImageView).image = UIImage(data: self.resultUser![indexPath.row].portrait! as Data)
        (cell.viewWithTag(21) as! UILabel).text = self.resultUser![indexPath.row].uname as? String
         (cell.viewWithTag(22) as! UILabel).text = (self.resultUser![indexPath.row].sex as? String)! + (self.resultUser![indexPath.row].emostate as? String)! + (self.resultUser![indexPath.row].birthday as? String)!
         (cell.viewWithTag(23) as! UILabel).text = self.resultUser![indexPath.row].hometown as? String
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let peopleDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "FeatureDetailViewController") as! FeatureDetailViewController
        peopleDetailVC.peopleInfo = self.resultUser![indexPath.row]
        self.navigationController?.pushViewController(peopleDetailVC, animated: true)
        
    }

}
