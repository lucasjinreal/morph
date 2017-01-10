//
//  NeedDetailViewController.swift
//  Morph
//
//  Created by JinTian on 8/9/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class NeedDetailViewController: UIViewController {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var namelabel: UILabel!
    
    @IBOutlet weak var needtitle: UILabel!
    
    @IBOutlet weak var needdiscription: UILabel!
    
    @IBOutlet weak var needlocation: UILabel!
    @IBOutlet weak var needtime: UILabel!
    @IBOutlet weak var needmoney: UILabel!
    @IBOutlet weak var needphone: UIButton!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    var fromsend_avatar: UIImage?
    var fromsend_name: String?
    var fromsend_needtitle: String?
    var fromsend_needdiscription: String?
    var fromsend_needlocation: String?
    var fromsend_needtime: String?
    var fromsend_needmoney: String?
    var fromsend_needphone: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view1.layer.cornerRadius = 10
        self.view2.layer.cornerRadius = 10
        
        
        self.avatar.image = fromsend_avatar
        self.namelabel.text = fromsend_name
        self.needtitle.text = fromsend_needtitle
        self.needlocation.text = fromsend_needlocation
        self.needtime.text = fromsend_needtime
        self.needmoney.text = fromsend_needmoney
        self.needphone.titleLabel?.text = fromsend_needphone

        self.avatar.layer.cornerRadius = self.avatar.frame.width/2
        self.avatar.layer.borderColor = UIColor.white.cgColor
        self.avatar.layer.borderWidth = 2
        self.avatar.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
