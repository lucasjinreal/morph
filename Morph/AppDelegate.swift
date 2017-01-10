//
//  AppDelegate.swift
//  WeatherDemo
//
//  Created by JinTian on 3/20/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit
import IQKeyboardManager




@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        Thread.sleep(forTimeInterval: TimeInterval(1.3))
        IQKeyboardManager.shared().isEnabled = true
       
        debugPrint(UserDefaults.standard.bool(forKey: "haslogin"))
        //获取当前app版本号
        let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        //获取之前保存的版本号
        let appVersion = UserDefaults.standard.value(forKey: "appVersion") as? String
        if appVersion == nil || appVersion != currentVersion{
            //如果是第一次打开或者是更新之后第一次打开就显示引导页面
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let guideVC = storyboard.instantiateViewController(withIdentifier: "GuideViewController")
            self.window?.rootViewController = guideVC
        }else{
            //如果不是第一次打开或者更新之后第一次打开就按照正常的登陆逻辑来判断
            if UserDefaults.standard.bool(forKey: "haslogin"){
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let maintabvc = storyboard.instantiateViewController(withIdentifier: "MainTabViewController")
                self.window?.rootViewController = maintabvc
            }else{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginvc = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                self.window?.rootViewController = loginvc
                
            }    
        }

        
        
        if let token = UserDefaults.standard.value(forKey: "userToken"){
            RCIMClient.shared().initWithAppKey("p5tvi9dstg8m4")
            RCIMClient.shared().connect(withToken: token as! String, success: { (userId) in
                debugPrint("当前用户: \(userId)")
                UserDefaults.standard.setValue(String(describing: userId), forKey: "userid")
                }, error: { (error) in
                    debugPrint(error)
            }) {
                debugPrint("token incorrect")
            }
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

