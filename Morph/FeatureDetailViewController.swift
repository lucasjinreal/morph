//
//  FeatureDetailViewController.swift
//  Morph
//
//  Created by JinTian on 6/2/16.
//  Copyright © 2016 JinTian. All rights reserved.
//
import UIKit

class FeatureDetailViewController: UIViewController {

   
    @IBAction func didTapChat(_ sender: AnyObject) {
        let sb = UIStoryboard.init(name: "Chat", bundle: Bundle.main)
        let conversationVC = sb.instantiateViewController(withIdentifier: "ConversationViewController") as! ConversationViewController
        conversationVC.chatPeopleInfo = self.peopleInfo
        self.navigationController?.pushViewController(conversationVC, animated: true)
        
    }
    
    @IBAction func didTapAdd(_ sender: AnyObject) {
        ProgressHUD.showSuccess("请求发送成功！", interaction: true)
    }
    @IBOutlet weak var backgroundimageview: UIImageView!
  
    @IBOutlet weak var visualView: UIVisualEffectView!
    
    @IBOutlet weak var tatumb: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var momentTableView: UITableView!
    var peopleInfo: PeopleModal?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.momentTableView.dataSource = self
        self.momentTableView.delegate = self
        
        //创建毛玻璃效果背景
        let blurEffect = UIBlurEffect(style: .light)
        self.visualView.effect = blurEffect
    }
    override func viewWillAppear(_ animated: Bool) {
        if self.peopleInfo != nil {
            self.tatumb.image = UIImage(data: (self.peopleInfo?.portrait)! as Data)
            self.name.text = self.peopleInfo?.uname as? String
            self.backgroundimageview.image = UIImage(data: (self.peopleInfo?.portrait)! as Data)
            self.tatumb.layer.cornerRadius = self.tatumb.frame.width/2
            self.tatumb.layer.borderWidth = 2
            self.tatumb.layer.borderColor = UIColor.white.cgColor
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}
extension FeatureDetailViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.momentTableView.dequeueReusableCell(withIdentifier: "MomentCell")! as UITableViewCell
        (cell.viewWithTag(202) as! UIImageView).layer.cornerRadius = 3
        (cell.viewWithTag(202) as! UIImageView).clipsToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.momentTableView.deselectRow(at: indexPath, animated: true)
    }
}
