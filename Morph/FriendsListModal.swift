//
//  FriendsListModal.swift
//  Morph
//
//  Created by JinTian on 15/10/2016.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class FriendsListModal: NSObject{
    var portrait: UIImage?
    var name: String?
    init(portrait: UIImage?, name: String?) {
        self.portrait = portrait
        self.name = name
    }
}
