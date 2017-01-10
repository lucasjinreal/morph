//
//  LoginViewController.swift
//  WeatherDemo
//
//  Created by JinTian on 3/29/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class LoginViewController: UIViewController, UITextFieldDelegate{
    @IBOutlet var idtextField:UITextField!
    @IBOutlet var pwtextField:UITextField!
    
    @IBOutlet weak var aboutbutton: UIButton!
    @IBOutlet weak var loginbutton: UIButton!
    @IBOutlet weak var logolabel: UILabel!
    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var visualeffectview: UIVisualEffectView!
    @IBOutlet weak var loginbk: UIImageView!
    @IBAction func login(_ sender: AnyObject) {
        let width = self.view.bounds.width
        let height = self.view.bounds.height
        self.view.backgroundColor = UIColor(red: 54/225, green: 54/225, blue: 54/225, alpha: 0.7)
        let frame = CGRect(x: width/2 - 40, y: height/2 - 40, width: 80, height: 80)
        let activityIndicatorView = NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.ballScaleMultiple, color: UIColor.white, padding: 0)
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        
        let id = idtextField.text! as String
        let password = pwtextField.text! as String
        //保存一下用户名和密码方便下次登录时不用继续输入
        UserDefaults.standard.setValue(id, forKey: "id")
        UserDefaults.standard.setValue(password, forKey: "password")
        if id == ""||password == ""{
            activityIndicatorView.stopAnimating()
            let alertvc = UIAlertController(title: "提示", message: "请输入学号和密码", preferredStyle: .alert)
            let action = UIAlertAction(title: "确定", style: .default, handler: nil)
            alertvc.addAction(action)
            self.present(alertvc, animated: true, completion: nil)
        }else{
            if Reachability.isConnectedToNetwork(){
                let params = [
                    "enter": "true",
                    "userName" : id,
                    "passWord" : password,
                    ]
                let url = "http://my.its.csu.edu.cn"
                Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default).responseString(completionHandler: { (string) in
                    print(string)
                })
                
                Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default).responseString { (string) in
                    let result = string.result
                    let htmlstr = result.value! as String
                    if htmlstr.contains("财务信息"){
                        let paramsHasRegister = [
                            "sid": id
                        ]
                        //请求是否在数据库中存在该用户
                        Alamofire.request("http://115.29.140.140/Morph/LoginServlet", method: .post, parameters: paramsHasRegister, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (r) in
                            
                            switch r.result{
                            case .success:
                                activityIndicatorView.stopAnimating()
                                let json = r.result.value as! NSDictionary
                                let name = json.value(forKey: "uname")
                                let sid = json.value(forKey: "sid")
                                let portraitUrl = json.value(forKey: "portraiturl")
                                
                                let getTokenParams = [
                                    "sid": sid! as! String,
                                    "name": name as! String,
                                    "url": portraitUrl as! String
                                ]
                                //保存用户的sid
                                UserDefaults.standard.setValue(sid, forKey: "sid")
                                //将信息保存至归档中，方便后面的页面进行本地读取
                                let userInfo = UserInfo()
                                userInfo.sid = sid as! String as NSString?
                                userInfo.uname = name as! String as NSString?
                                //获取头像图片并保存
                                let url: NSURL = NSURL(string: portraitUrl as! String)!
                                let portraitData : NSData = NSData(contentsOf:url as URL)!
                                userInfo.portrait = portraitData as Data
                                userInfo.major = "信息院"
                                let userData = NSKeyedArchiver.archivedData(withRootObject: userInfo)
                                UserDefaults.standard.set(userData, forKey: "userinfo")
                                print("第一次登陆用户信息保存成功")

                                //获取到了用户在获取token
                                Alamofire.request("http://115.29.140.140/MorphGetTokenServlet", method: .post, parameters: getTokenParams, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                                    switch response.result{
                                    case .success:
                                        let json = response.result.value as! NSDictionary
                                        print(json)
                                        let result = json.value(forKey: "result") as! NSDictionary
                                        print(result)
                                        let token = result.value(forKey: "token")
                                        //保存usertoken
                                        if token != nil{
                                            UserDefaults.standard.setValue(token!, forKey: "userToken")
                                        }
                                    case .failure:
                                        print("请求token失败")
                                    }
                                })
                                
                                ProgressHUD.showSuccess("登录成功")
                                let registerSuccess = DispatchQueue(label: "registerSuccess")
                                registerSuccess.async {
                                    Thread.sleep(forTimeInterval: 2)
                                    DispatchQueue.main.async(execute: {
                                        let mainTabViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabViewController")
                                        self.present(mainTabViewController!, animated: true, completion: nil)
                                        UserDefaults.standard.set(true, forKey: "haslogin")
                                    })

                                }
                                
                                case .failure:
                                print("用户未注册")
                                activityIndicatorView.stopAnimating()
                                let nav = self.storyboard?.instantiateViewController(withIdentifier: "setupnavigation")
                                self.present(nav!, animated: true, completion: nil)
                            }
                        })
                        
                    }else{
                        activityIndicatorView.stopAnimating()
                        let alertvc = UIAlertController(title: "学号或密码错误", message: "校外人员无法登陆", preferredStyle: .alert)
                        let action = UIAlertAction(title: "确定", style: .default, handler: nil)
                        alertvc.addAction(action)
                        self.present(alertvc, animated: true, completion: nil)
                    }
                }

            }else{
                activityIndicatorView.stopAnimating()
                let alert = UIAlertController(title: "当前网络不可用", message: "貌似连不上网哦", preferredStyle: .alert)
                let action = UIAlertAction(title: "确定", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
            
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.avatar.layer.cornerRadius = self.avatar.frame.width/2
        self.avatar.layer.borderWidth = 2
        self.avatar.layer.borderColor = UIColor.white.cgColor
        self.avatar.clipsToBounds = true
        self.idtextField.layer.cornerRadius = self.idtextField.frame.height/2
        self.idtextField.layer.borderWidth = 0.5
        self.idtextField.layer.borderColor = UIColor.black.cgColor
        
        self.pwtextField.layer.cornerRadius = self.idtextField.frame.height/2
        self.pwtextField.layer.borderWidth = 0.5
        self.pwtextField.layer.borderColor = UIColor.black.cgColor
        self.pwtextField.isSecureTextEntry = true
        let blureffect = UIBlurEffect(style: .light)
        self.visualeffectview.effect = blureffect
        idtextField.delegate = self
        pwtextField.delegate = self
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LoginViewController.handleTap(_:))))
        
        self.logolabel.text = "欢迎来到morph"
        
        if let id = UserDefaults.standard.value(forKey: "id"){
            self.idtextField.text = id as? String
        }else{
            self.idtextField.text = ""
        }
        
        if let password = UserDefaults.standard.value(forKey: "password"){
            self.pwtextField.text = password as? String
        }else{
            self.pwtextField.text = ""
        }
    
    }
    
    //动画函数
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: [], animations: {
            self.loginbutton.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
            self.loginbutton.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        UIView.animate(withDuration: 1, delay: 0.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: [], animations: {
            self.aboutbutton.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
            self.aboutbutton.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
    
    }
    func handleTap(_ sender: UIGestureRecognizer){
        if sender.state == .ended{
            idtextField.resignFirstResponder()
            pwtextField.resignFirstResponder()
        }
        sender.cancelsTouchesInView = false
        
    }
    
    override func viewDidLayoutSubviews() {
        self.scrollview.contentSize = CGSize(width: CGFloat(self.view.bounds.width), height: CGFloat(700))
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if (textField == idtextField!){
            idtextField!.resignFirstResponder()
            pwtextField.isFirstResponder
        }else if(textField == pwtextField!){
            pwtextField!.resignFirstResponder()
            
        }
        return true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
}
