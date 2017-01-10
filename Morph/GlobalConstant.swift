//
//  GlobalConstant.swift
//  Morph
//
//  Created by JinTian on 25/12/2016.
//  Copyright © 2016 JinTian. All rights reserved.
//
import UIKit
import Foundation



/*********颜色***********/
//RGB转换
func RGB(_ r:CGFloat,g:CGFloat,b:CGFloat) ->UIColor{
    //
    return UIColor(red: r/225.0, green: g/225.0, blue: b/225.0, alpha: 1.0)
}

/*********尺寸***********/

//设备屏幕尺寸
public let SCREEN_WIDTH=UIScreen.main.bounds.size.width
public let SCREEN_HEIGHT=UIScreen.main.bounds.size.height

//获取视图尺寸
public func VIEW_WIDTH(_ view:UIView)->CGFloat{
    return view.frame.size.width
}
public func VIEW_HEIGHT(_ view:UIView)->CGFloat{
    return view.frame.size.height
}

/*********网络***********/

//判断网络是否可用
public func NETWORK_AVILIABLE()->Bool{

    if (Reachability.isConnectedToNetwork()){
        print("网络可用！")
        return true
    }
    else{
        print("网络不可用！")
        return false
    }
        
}
