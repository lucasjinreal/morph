//
//  YuanViewController.swift
//  Morph
//
//  Created by JinTian on 5/10/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit
import Spring

class YuanViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
 
    @IBOutlet weak var matchlabel: UILabel!
    @IBOutlet weak var bestmatchview: UIView!
    @IBOutlet weak var peoplesuggestview: UIView!
    @IBOutlet weak var imageta: SpringImageView!
    @IBOutlet weak var imageme: SpringImageView!

    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var headcollectionview: UICollectionView!
    @IBOutlet weak var featurecollectionview: UICollectionView!
    @IBOutlet weak var datebutton: UIButton!
    let pic = ["f_5", "f_12", "f_4", "f_11", "f_14", "f_1", "f_3", "f_2"]
    let headpic = ["pic_1", "pic_2", "pic_3", "pic_1"]
    var featurePeople: [PeopleModal] = []
    
    
    @IBAction func didTapDateButton(_ sender: AnyObject) {
        PopupController
        .create(self)
        .customize(
            [
                .animation(.slideUp),
                .scrollable(false),
                .backgroundStyle(.blackFilter(alpha: 0.7))
            ]
        )
        .show(DatePopupViewController.instance())
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //把两个view圆角化
        self.peoplesuggestview.layer.cornerRadius = 8
        self.bestmatchview.layer.cornerRadius = 8
        
        
        headcollectionview.dataSource = self
        headcollectionview.delegate = self
        featurecollectionview.dataSource = self
        featurecollectionview.delegate = self
        
        
        headcollectionview.showsHorizontalScrollIndicator = false;
        let collectionPageViewLayout : YuanCollectionViewFlowLayout = YuanCollectionViewFlowLayout()
        headcollectionview.setCollectionViewLayout(collectionPageViewLayout, animated: false);
        
        headcollectionview.register(UINib(nibName: "YuanCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "yuancollectioncell")
    
        //设置contentsize，不然滚动不起来这个scrollview
        scrollview.contentSize = CGSize(width: CGFloat(self.view.bounds.width), height: CGFloat(700))
        
        //对图像进行一个预先处理
        self.imageta.layer.cornerRadius = self.imageta.frame.width/2
        self.imageta.layer.masksToBounds = true
        self.imageme.layer.cornerRadius = self.imageme.frame.width/2
        self.imageme.layer.masksToBounds = true
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupAnimations()
        self.tabBarController?.tabBar.barStyle = .default

    }
    override func viewWillAppear(_ animated: Bool) {
        if let userData = UserDefaults.standard.object(forKey: "userinfo") as? Data{
            if let userinfo = NSKeyedUnarchiver.unarchiveObject(with: userData) as? UserInfo{
                let imageData = userinfo.portrait! as Data
                let image = UIImage(data: imageData)
                self.imageme.image = image
            }else{
                if let userinfo = NSKeyedUnarchiver.unarchiveObject(with: userData) as? UserInfo{
                    if userinfo.sex == "男" {
                        self.imageme.image = UIImage(named: "default_m")
                    }else{
                        self.imageme.image = UIImage(named: "default_f")
                    }
                }
            }
        }
        self.loadFeaturePeopleData()

    }
    
    func loadFeaturePeopleData(){
        let imageData1 = UIImageJPEGRepresentation(UIImage(named: "f_1")!, 0.9)
        let people1 = PeopleModal(sid: "1122", uname: "小王", sex: "女", hometown: "江西南昌", emostate: "单身", birthday: "1993-12-11", portrait: imageData1, major: nil)
        
        let imageData2 = UIImageJPEGRepresentation(UIImage(named: "f_2")!, 0.9)
        let people2 = PeopleModal(sid: "1840062", uname: "韩雪", sex: "女", hometown: "江西南昌", emostate: "单身", birthday: "1993-12-11", portrait: imageData2, major: nil)

        let imageData3 = UIImageJPEGRepresentation(UIImage(named: "f_3")!, 0.9)
        let people3 = PeopleModal(sid: "134562", uname: "轩中", sex: "男", hometown: "江西南昌", emostate: "单身", birthday: "1993-12-11", portrait: imageData3, major: nil)

        let imageData4 = UIImageJPEGRepresentation(UIImage(named: "f_4")!, 0.9)
        let people4 = PeopleModal(sid: "46788432", uname: "巴可夫斯基", sex: "男", hometown: "江西南昌", emostate: "单身", birthday: "1993-12-11", portrait: imageData4, major: nil)
        self.featurePeople.append(people1)
        self.featurePeople.append(people2)
        self.featurePeople.append(people3)
        self.featurePeople.append(people4)

    }
    
    func setupAnimations(){
        self.imageta.animation = "pop"
        self.imageta.delay = 0.4
        self.imageta.duration = 3
        self.imageta.animate()
      
        
        self.imageme.animation = "pop"
        self.imageme.delay = 0.4
        self.imageme.duration = 3
        self.imageme.animate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(_ segue: UIStoryboardSegue){
        self.datebutton.setTitle("等待对方回复中", for: UIControlState())
        self.datebutton.isEnabled = false
        
    }
    
}


extension YuanViewController{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView.tag == 1002{
            return 1
        }else{
            return 1
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if collectionView.tag == 1002{
            return 4
        }else{
            return self.featurePeople.count
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1002{
            let cell = headcollectionview.dequeueReusableCell(withReuseIdentifier: "yuancollectioncell", for: indexPath) as! YuanCollectionViewCell
            cell.picture.image = UIImage(named: self.headpic[indexPath.row])
            return cell
        }else{
            let cell = featurecollectionview.dequeueReusableCell(withReuseIdentifier: "featurecell", for: indexPath)
            (cell.contentView.viewWithTag(1) as! UIImageView).image = UIImage(data: self.featurePeople[indexPath.row].portrait! as Data)
            (cell.contentView.viewWithTag(1) as! UIImageView).layer.cornerRadius = (cell.contentView.viewWithTag(1) as! UIImageView).frame.width/2
            (cell.contentView.viewWithTag(1) as! UIImageView).layer.masksToBounds = true
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1000{
            let featureDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "FeatureDetailViewController") as! FeatureDetailViewController
            featureDetailVC.peopleInfo = self.featurePeople[indexPath.row]
            self.navigationController?.pushViewController(featureDetailVC, animated: true)
            
        }else{
            self.performSegue(withIdentifier: "toyuanheaddetail", sender: self)
        }
        
    }

  
        
}

