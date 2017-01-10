//
//  GuideViewController.swift
//  Morph
//
//  Created by JinTian on 17/11/2016.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var contentView: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        self.startButton.layer.cornerRadius = 8
        UIView.animate(withDuration: 2, delay: 0, options: [], animations: {
            
            self.startButton.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.startButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            
            }, completion: nil)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 2, delay: 2, options: [], animations: {
            self.contentView.alpha = 0.3
            self.contentView.alpha = 0.6
            self.contentView.alpha = 0.9
            self.contentView.alpha = 1
            }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(_ animated: Bool) {
        let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        UserDefaults.standard.setValue(appVersion, forKey: "appVersion")

    }

}
