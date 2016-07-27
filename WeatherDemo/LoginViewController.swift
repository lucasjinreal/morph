//
//  LoginViewController.swift
//  WeatherDemo
//
//  Created by JinTian on 3/29/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit
import TextFieldEffects
import LTMorphingLabel
import Alamofire
import NVActivityIndicatorView




class LoginViewController: UIViewController, UITextFieldDelegate{
    @IBOutlet var idtextField:MyKaedeTextField!
    @IBOutlet var pwtextField:MyKaedeTextField!
    
    @IBOutlet weak var aboutbutton: UIButton!
    @IBOutlet weak var loginbutton: UIButton!
    @IBOutlet weak var logolabel: LTMorphingLabel!
    
    @IBOutlet weak var loginbk: UIImageView!
    @IBAction func login(sender: AnyObject) {
        let width = self.view.bounds.width
        let height = self.view.bounds.height
        self.view.backgroundColor = UIColor(red: 54/225, green: 54/225, blue: 54/225, alpha: 0.7)
        let frame = CGRect(x: width/2 - 40, y: height/2 - 40, width: 80, height: 80)
        let activityIndicatorView = NVActivityIndicatorView(frame: frame, type: .BallScaleMultiple)
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimation()
        
        let id = idtextField.text! as String
        let password = pwtextField.text! as String
        if id == ""||password == ""{
            activityIndicatorView.stopAnimation()
            let alertvc = UIAlertController(title: "提示", message: "请输入学号和密码", preferredStyle: .Alert)
            let action = UIAlertAction(title: "确定", style: .Default, handler: nil)
            alertvc.addAction(action)
            self.presentViewController(alertvc, animated: true, completion: nil)
        }else{
            let params = [
                "enter": "true",
                "userName" : id,
                "passWord" : password,
                ]
            let url = "http://my.its.csu.edu.cn"
            Alamofire.request(.POST, url, parameters: params, encoding: .URL).responseString { (string) in
                let result = string.result
                let htmlstr = result.value! as String
                if htmlstr.containsString("财务信息"){
                    activityIndicatorView.stopAnimation()
                    let nav = self.storyboard?.instantiateViewControllerWithIdentifier("setupnavigation")
                    self.presentViewController(nav!, animated: true, completion: nil)
                }else{
                    activityIndicatorView.stopAnimation()
                    let alertvc = UIAlertController(title: "学号或密码错误", message: "校外人员无法登陆", preferredStyle: .Alert)
                    let action = UIAlertAction(title: "确定", style: .Default, handler: nil)
                    alertvc.addAction(action)
                    self.presentViewController(alertvc, animated: true, completion: nil)
                }
            }

        }
            
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        //Mark: setting the width and height of screen
        let width = Int(self.view.bounds.width)
        let height = Int(self.view.bounds.height)
        //Mark: Personlize textfieldeffects
        idtextField = MyKaedeTextField(frame: CGRect(x: (Int(width)/2)-100, y:(height/4)+80 , width: 200, height: 35))
        idtextField.layer.cornerRadius = 17.5
        idtextField.placeholderColor = UIColor(red: 244/255, green: 245/255, blue: 246/255, alpha: 0.5)
        idtextField.placeholder = "学号"
        idtextField.foregroundColor = UIColor(red: 241/255, green: 242/255, blue: 241/255, alpha: 0.1)
        idtextField.textColor = UIColor(red: 244/255, green: 245/255, blue: 246/255, alpha: 0.7)
        
        idtextField.clearButtonMode = UITextFieldViewMode.UnlessEditing
        idtextField.returnKeyType = UIReturnKeyType.Next
        
        pwtextField = MyKaedeTextField(frame: CGRect(x: (Int(width)/2)-100, y:(height/4)+120 , width: 200, height: 35))
        pwtextField.layer.cornerRadius = 17.5
        pwtextField.placeholderColor = UIColor(red: 244/255, green: 245/255, blue: 246/255, alpha: 0.5)
        pwtextField.placeholder = "密码"
        pwtextField.foregroundColor = UIColor(red: 241/255, green: 242/255, blue: 241/255, alpha: 0.1)
        pwtextField.textColor = UIColor(red: 244/255, green: 245/255, blue: 246/255, alpha: 0.7)
        pwtextField.secureTextEntry = true
        pwtextField.clearButtonMode = UITextFieldViewMode.UnlessEditing
        //idtextField.keyboardType = UIKeyboardType.NumberPad
        pwtextField.returnKeyType = UIReturnKeyType.Done
        
        idtextField.delegate = self
        pwtextField.delegate = self
        view.addSubview(idtextField)
        view.addSubview(pwtextField)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LoginViewController.handleTap(_:))))
        
        self.logolabel.text = "Welcome to Morph"
        let effect = LTMorphingEffect(rawValue: 0)
        logolabel.morphingEffect = effect!
    
    }
    
    //动画函数
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(1, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: [], animations: {
            self.loginbutton.transform = CGAffineTransformMakeScale(1.8, 1.8)
            self.loginbutton.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: nil)
        UIView.animateWithDuration(1, delay: 0.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: [], animations: {
            self.aboutbutton.transform = CGAffineTransformMakeScale(1.8, 1.8)
            self.aboutbutton.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: nil)
    
    }
    func handleTap(sender: UIGestureRecognizer){
        if sender.state == .Ended{
            idtextField.resignFirstResponder()
            pwtextField.resignFirstResponder()
        }
        sender.cancelsTouchesInView = false
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        if (textField == idtextField!){
            idtextField!.resignFirstResponder()
            pwtextField.isFirstResponder()
        }else if(textField == pwtextField!){
            pwtextField!.resignFirstResponder()
            
        }
        return true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
}
class MyKaedeTextField: KaedeTextField {
    
    let padding = UIEdgeInsets(top: 0, left: 55, bottom: 0, right: 0);
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        let frame = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width * 0.6, height: bounds.size.height))
        
        return CGRectInset(frame, 25, 0)
    }
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        let frame = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width * 0.6, height: bounds.size.height))
        
        return CGRectInset(frame, 25, 0)
    }}
