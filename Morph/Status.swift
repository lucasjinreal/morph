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
    var discribe: String?
    var content: String?
    var time: String?
    var pictures: [UIImage?]?
    var devicemodel: String?
    var commentcount: Int?
    var likecount: Int?
    
    init(avatar_url: String?, name: String?, discribe: String?, content: String?, time: String?, pictures: [UIImage?]?, devicemodel: String?, commentcount: Int?, likecount: Int?) {
        self.avatar_url = avatar_url
        self.name = name
        self.discribe = discribe
        self.content = content
        self.time = time
        self.pictures = pictures
        self.devicemodel = devicemodel
        self.commentcount = commentcount
        self.likecount = likecount
    }
}