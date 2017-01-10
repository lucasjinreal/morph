//
//  FeedsModel.swift
//  WeatherDemo
//
//  Created by JinTian on 3/29/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class FeedsModel: NSObject {
    var picurl:String
    var title:String
    var urlid: String
    
    init(title:String, picurl:String, urlid: String){
        self.picurl = picurl
        self.title = title
        self.urlid = urlid
        
    }
    
}
