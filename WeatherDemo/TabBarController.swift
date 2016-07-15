//
//  TabBarController.swift
//  WeatherDemo
//
//  Created by JinTian on 3/25/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    
    let itemnameArray:[String]=["diamond L", "crown L", "chair L-1", "alien L"]
    let itemselectednameArray:[String]=["diamond F", "crown F", "chair F", "alien F"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.configTabbar()
        self.tabBar.tintColor = UIColor.redColor()
        
    }
    
    //Configure the tabbar item
    func configTabbar(){
        var count:Int = 0
        let items = self.tabBar.items
        for item in items! as [UITabBarItem]{
            var image:UIImage = UIImage(named: itemnameArray[count])!
            var selectedImage:UIImage = UIImage(named: itemselectednameArray[count])!
            image = image.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            selectedImage = selectedImage.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            item.selectedImage = selectedImage
            item.image = image
            count += 1
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
