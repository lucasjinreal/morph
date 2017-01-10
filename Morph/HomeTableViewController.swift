//
//  HomeTableViewController.swift
//  Morph
//
//  Created by JinTian on 04/12/2016.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    @IBOutlet weak var headerCollectionView: UICollectionView!
    @IBOutlet weak var newsCollectionView: UICollectionView!
    @IBOutlet weak var storeCollectionView: UICollectionView!
    @IBOutlet weak var bottomLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item = UIBarButtonItem(title: "返回", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
        let attr: NSDictionary = [NSFontAttributeName: UIFont(name: "Futura", size: 15)!]
        self.navigationController?.navigationBar.titleTextAttributes = attr as? [String: AnyObject]
        
        self.bottomLabel.font = UIFont(name: "iconfont", size: 10)
        self.bottomLabel.text = "\u{e608} ouman-IT \u{e606} 326237858 \u{e64b} Morph长沙校园圈"
        
        self.newsCollectionView.dataSource = self
        self.newsCollectionView.delegate = self
        self.storeCollectionView.dataSource = self
        self.storeCollectionView.delegate = self
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize.width = (UIScreen.main.bounds.width - 24)/2
        flowLayout.itemSize.height = 120
        flowLayout.minimumLineSpacing = 1
        self.newsCollectionView.collectionViewLayout = flowLayout
        
        let flowLayout2 = UICollectionViewFlowLayout()
        flowLayout2.itemSize.width = 120
        flowLayout2.itemSize.height = 80
        flowLayout.minimumInteritemSpacing = 1
        flowLayout2.scrollDirection = .horizontal
        self.storeCollectionView.collectionViewLayout = flowLayout2
        
        let flowLayout3 = UICollectionViewFlowLayout()
        flowLayout3.itemSize.width = 70
        flowLayout3.itemSize.height = 90
        flowLayout3.minimumInteritemSpacing = 50
        flowLayout3.scrollDirection = .horizontal
        self.headerCollectionView.collectionViewLayout = flowLayout3
        

      
    }
    override func viewWillAppear(_ animated: Bool) {
        if let homeBackgroundData = UserDefaults.standard.value(forKey: "homeBackground") as? Data{
            let homeBackgroundImage = UIImage(data: homeBackgroundData)
            
            let visualView = UIVisualEffectView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
            let blurlEffect = UIBlurEffect(style: .light)
            visualView.effect = blurlEffect
            
            self.tableView.backgroundView = UIImageView(image: homeBackgroundImage)
            self.tableView.backgroundView?.addSubview(visualView)
        }else{
            let visualView = UIVisualEffectView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
            let blurlEffect = UIBlurEffect(style: .light)
            visualView.effect = blurlEffect
            self.tableView.backgroundView = UIImageView(image: UIImage(named: "bk_5"))
            self.tableView.backgroundView?.addSubview(visualView)
            
        }
        
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.backgroundColor = UIColor.white
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

    
}
extension HomeTableViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1001 {
            return 4
        }else if collectionView.tag == 1003{
            return 3
        }else{
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1001 {
            let cell = self.newsCollectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as UICollectionViewCell
            (cell.viewWithTag(101) as! UIImageView).image = UIImage(named: "home_1")
            (cell.viewWithTag(101) as! UIImageView).layer.cornerRadius = 6
            (cell.viewWithTag(101) as! UIImageView).clipsToBounds = true
            (cell.viewWithTag(102) as! UILabel).text = "长沙百名大学生线下活动"
            return cell
        }else if collectionView.tag == 1003{
            let cell = self.headerCollectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCell", for: indexPath) as UICollectionViewCell
            (cell.viewWithTag(110) as! UIVisualEffectView).layer.cornerRadius = (cell.viewWithTag(110) as! UIVisualEffectView).frame.height/2
            (cell.viewWithTag(110) as! UIVisualEffectView).clipsToBounds = true
            (cell.viewWithTag(111) as! UILabel).text = "黑科技"
            return cell
            
        }else{
            let cell = self.storeCollectionView.dequeueReusableCell(withReuseIdentifier: "StoreCell", for: indexPath) as UICollectionViewCell
            (cell.viewWithTag(108) as! UIImageView).image = UIImage(named: "home_3")
            (cell.viewWithTag(108) as! UIImageView).layer.cornerRadius = 6
            (cell.viewWithTag(108) as! UIImageView).clipsToBounds = true
            return cell
        }
    }
}
