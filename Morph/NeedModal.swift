//
//  NeedModal.swift
//  Morph
//
//  Created by JinTian on 8/6/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class NeedModal: NSObject {
    var avatar: UIImage?
    var needtitle: String?
    var needname: String?
    var needdiscription: String?
    var needlocation: String?
    var needmoney: String?
    var needtime: String?
    var needphone: String?
    
    init(avatar: UIImage?, needtitle: String?, needname: String?, needdiscription: String?,needlocation: String?, needmoney: String?, needtime: String?, needphone: String?) {
        
        self.avatar = avatar
        self.needtitle = needtitle
        self.needname = needname
        self.needdiscription = needdiscription
        self.needlocation = needlocation
        self.needmoney = needmoney
        self.needtime = needtime
        self.needphone = needphone
        
    }
}
