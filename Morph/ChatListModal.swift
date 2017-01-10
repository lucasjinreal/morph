//
//  ChatListModal.swift
//  Morph
//
//  Created by JinTian on 7/27/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class ChatListModal: NSObject {
    
    var portrait: UIImage?
    var name: String?
    var contenttext: String?
    var time: String?
    
    
    init(portrait: UIImage?, name: String?, contenttext: String?, time: String?) {

    self.portrait = portrait
    self.name = name
    self.contenttext = contenttext
    self.time = time
    }
}
