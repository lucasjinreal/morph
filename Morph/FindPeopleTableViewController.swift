//
//  FindPeopleTableViewController.swift
//  Morph
//
//  Created by JinTian on 07/12/2016.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit
import Alamofire

class FindPeopleTableViewController: UITableViewController {

    @IBOutlet weak var sidTextField: UITextField!
    @IBOutlet weak var conditionSearchButton: UIButton!
    
    @IBAction func didTapConditionSearch(_ sender: AnyObject) {
        let resultVC = self.storyboard?.instantiateViewController(withIdentifier: "FindResultTableViewController") as! FindResultTableViewController
        self.navigationController?.pushViewController(resultVC, animated: true)
    }
    @IBOutlet weak var genderCell: UITableViewCell!
    @IBOutlet weak var majorCell: UITableViewCell!
    @IBOutlet weak var ageCell: UITableViewCell!
    @IBAction func didTapPreciseSearch(_ sender: AnyObject) {
        self.preciseSearch()
        
    }
        

        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.conditionSearchButton.layer.cornerRadius = self.conditionSearchButton.frame.height/2

    }
    
    func preciseSearch(){
        ProgressHUD.show("正在查找", interaction: true)
        var resultUser: [PeopleModal] = []
        let searchUserAPI = "http://115.29.140.140/Morph/SearchUserServlet"
        if let sid = self.sidTextField.text{
            let params = [
                "sid": sid
            ]
            Alamofire.request(searchUserAPI, method: .post, parameters: params, encoding: URLEncoding.default).responseJSON(completionHandler: { (r) in
                switch r.result{
                case .success:
                    //这里从服务器获取的是json数组，处理分三步
                    //1. 根据返回的值直接获取到data
                    //2. 如果是数组就读取为数组，如果是json就读取为字典
                    //3. 根据数组获取到元素
                    if r.result.value != nil{
                        let jsonData = try? JSONSerialization.data(withJSONObject: r.result.value!, options: [])
                        let jsonArray = try? JSONSerialization.jsonObject(with: jsonData!, options: .mutableContainers) as! NSArray
                        if jsonArray?.count != 0{
                            let json = jsonArray?.object(at: 0) as! NSDictionary
                            let resultSid = json.value(forKey: "sid")
                            let resultEmostate = json.value(forKey: "emostate")
                            let resultHometown = json.value(forKey: "hometown")
                            let resultName = json.value(forKey: "uname")
                            let resultGender = json.value(forKey: "sex")
                            let resultPortrait = json.value(forKey: "portraiturl")
                            let resultBirthday = json.value(forKey: "birthday")
                            let url : NSURL = NSURL(string: resultPortrait as! String)!
                            let portraitData : NSData = NSData(contentsOf:url as URL)!
                            let userResult  = PeopleModal(sid: resultSid as? NSString, uname: resultName as? NSString, sex: resultGender as! String as NSString?, hometown: resultHometown as! NSString?, emostate: resultEmostate as! NSString?, birthday: resultBirthday as! NSString?, portrait: portraitData as Data, major: nil)
                            resultUser.append(userResult)
                            
                        }
                        
                    }
                    break
                case .failure:
                    break
                    
                }
                
            })
            
            let searchQueue = DispatchQueue(label: "searchQueuq", attributes: [])
            searchQueue.async {
                Thread.sleep(forTimeInterval: 2)
                DispatchQueue.main.async(execute: {
                    ProgressHUD.dismiss()
                    let resultVC = self.storyboard?.instantiateViewController(withIdentifier: "FindResultTableViewController") as! FindResultTableViewController
                    resultVC.resultUser = resultUser
                    print("开始跳转")
                    self.navigationController?.pushViewController(resultVC, animated: true)
                })}
            }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.genderCell.isSelected == true {
            let alertController = UIAlertController(title: "选择性别", message: "选择你喜欢的性别", preferredStyle: .actionSheet)
            let archiveAction1 = UIAlertAction(title: "女", style: .default, handler: {action in self.genderCell.detailTextLabel?.text = "女"
                self.genderCell.setSelected(false, animated: true)})
            let concelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let archiveAction = UIAlertAction(title: "男", style: .default, handler: {action in self.genderCell.detailTextLabel?.text = "男"
                self.genderCell.setSelected(false, animated: true)})
            alertController.addAction(archiveAction)
            alertController.addAction(archiveAction1)
            alertController.addAction(concelAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }

}
