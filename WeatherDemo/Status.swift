//
//  Status.swift
//  Morph
//
//  Created by JinTian on 7/17/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class Status: NSObject {
    var avatar_url: String?
    var name: String?
    var sign: String?
    var content: String?
    var time: String?
    var picture_url: UIImage?
    
    init(avatar_url: String?, name: String?, sign: String?, content: String?, time: String?, picture_url: UIImage?) {
        self.avatar_url = avatar_url
        self.name = name
        self.sign = sign
        self.content = content
        self.time = time
        self.picture_url = picture_url
    }
}