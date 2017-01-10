//
//  UserInfo.swift
//  Morph
//
//  Created by JinTian on 11/11/2016.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class UserInfo: NSObject, NSCoding {
    var sid: NSString?
    var uname: NSString?
    var sex: NSString?
    var hometown: NSString?
    var emostate: NSString?
    var birthday: NSString?
    var portrait: Data?
    var discribe: NSString?
    var major: NSString?
    var dateanounce: NSString?

    func encode(with aCoder: NSCoder) {
        if let sid = self.sid{
            aCoder.encode(sid, forKey: "sid")
        }
        if let uname = self.uname{
            aCoder.encode(uname, forKey: "uname")
        }
        if let sex = self.sex{
            aCoder.encode(sex, forKey: "sex")
        }
        if let hometown = self.hometown{
            aCoder.encode(hometown, forKey: "hometown")
        }
        if let emostate = self.emostate{
            aCoder.encode(emostate, forKey: "emostate")
        }
        if let birthday = self.birthday{
            aCoder.encode(birthday, forKey: "birthday")
        }
        if let portrait = self.portrait{
            aCoder.encode(portrait, forKey: "portrait")
        }
        if let discribe = self.discribe{
            aCoder.encode(discribe, forKey: "discribe")
        }
        if let major = self.major{
            aCoder.encode(major, forKey: "major")
        }
        if let dateanounce = self.dateanounce{
            aCoder.encode(dateanounce, forKey: "dateanounce")
        }
    }
    override init() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.sid = aDecoder.decodeObject(forKey: "sid") as? NSString
        self.uname = aDecoder.decodeObject(forKey: "uname") as? NSString
        self.sex = aDecoder.decodeObject(forKey: "sex") as? NSString
        self.hometown = aDecoder.decodeObject(forKey: "hometown") as? NSString
        self.emostate = aDecoder.decodeObject(forKey: "emostate") as? NSString
        self.birthday = aDecoder.decodeObject(forKey: "birthday") as? NSString
        self.portrait = aDecoder.decodeObject(forKey: "portrait") as? Data
        self.discribe = aDecoder.decodeObject(forKey: "discribe") as? NSString
        self.major = aDecoder.decodeObject(forKey: "major") as? NSString
        self.dateanounce = aDecoder.decodeObject(forKey: "dateanounce") as? NSString


    }
    
   
    
}
