//
//  TabBarController.swift
//  WeatherDemo
//
//  Created by JinTian on 3/25/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

   

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.configTabbar()
        self.tabBar.tintColor = UIColor(hex: "f04441")
        
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
