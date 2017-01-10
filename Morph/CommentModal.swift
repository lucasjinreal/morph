//
//  CommentModal.swift
//  Morph
//
//  Created by JinTian on 7/27/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class CommentModal: NSObject {
    
    var avatar: UIImage?
    var username: String?
    var commentcontent: String
    var commenttime: String?
    var replyarray: [String?]?
    
    init(avatar: UIImage?, username: String?, commentcontent: String, commenttime: String?, replyarray: [String?]?) {
        
        self.avatar = avatar
        self.username = username
        self.commentcontent = commentcontent
        self.commenttime = commenttime
        self.replyarray = replyarray
        
    }
}
