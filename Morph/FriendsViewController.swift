//
//  FriendsViewController.swift
//  Morph
//
//  Created by JinTian on 15/10/2016.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit
import Alamofire

class FriendsViewController: UIViewController{

    @IBOutlet weak var friendstableview: UITableView!
    var friendsArray: [FriendsListModal?] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.loadFriendsList()
        self.loadData()
        
        self.friendstableview.setEditing(false, animated: true)
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    
    }
    func loadData() {
        let friendsAPI = "http://115.29.140.140/Morph/getFriend.RelationServlet"
        let sid = UserDefaults.standard.value(forKey: "sid") as? String
        print(sid)
        let params = [
            "userID": sid!
        ]
        
        Alamofire.request(friendsAPI, method: .post, parameters: params, encoding: URLEncoding.default).responseJSON { (r) in
            print(r.result.value)
            print(r.result)
        }
    }
    
    func loadFriendsList(){
        // Do any additional setup after loading the view.
        let friend1 = FriendsListModal(portrait: UIImage(named: "f_2"), name: "乔布斯")
        let friend2 = FriendsListModal(portrait: UIImage(named: "f_3"), name: "碧昂斯")
        let friend3 = FriendsListModal(portrait: UIImage(named: "f_4"), name: "小明")
        let friend4 = FriendsListModal(portrait: UIImage(named: "f_5"), name: "阿凡达")
        let friend5 = FriendsListModal(portrait: UIImage(named: "f_6"), name: "习近平")
        let friend6 = FriendsListModal(portrait: UIImage(named: "f_7"), name: "玛德")
        self.friendsArray.append(friend1)
        self.friendsArray.append(friend2)
        self.friendsArray.append(friend3)
        self.friendsArray.append(friend4)
        self.friendsArray.append(friend5)
        self.friendsArray.append(friend6)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension FriendsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.friendsArray.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = self.friendstableview.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsTableViewCell
        cell.friendsList = friendsArray[indexPath.row]
       
        return cell
    }
 
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "确认删除好友"
    }
    
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        self.friendstableview.setEditing(editing, animated: true)
        if self.isEditing{
            self.editButtonItem.title = "Done"
        }else{
            self.editButtonItem.title = "Edit"
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            self.friendsArray.remove(at: indexPath.row)
            self.friendstableview.deleteRows(at: [indexPath], with: UITableViewRowAnimation.middle)
        }
    }
    


}
