//
//  SearchResultModal.swift
//  Morph
//
//  Created by JinTian on 11/12/2016.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class PeopleModal: NSObject{
    var sid: NSString?
    var uname: NSString?
    var sex: NSString?
    var hometown: NSString?
    var emostate: NSString?
    var birthday: NSString?
    var portrait: Data?
    var major: NSString?
    
    init(sid: NSString?, uname: NSString?, sex: NSString?, hometown: NSString?,emostate: NSString?, birthday: NSString?, portrait: Data?, major: NSString? ) {
        self.uname = uname
        self.portrait = portrait
        self.sid = sid
        self.sex = sex
        self.hometown = hometown
        self.emostate = emostate
        self.birthday = birthday
        self.major = major
    }
}
