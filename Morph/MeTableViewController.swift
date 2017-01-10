//
//  MeTableViewController.swift
//  Morph
//
//  Created by JinTian on 4/16/16.
//  Copyright © 2016 JinTian. All rights reserved.
//
import UIKit
import Alamofire


class MeTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    var myPicker:UIPickerView!
    var pickerDic:NSDictionary!
    var provinceArray:NSArray!
    var cityArray:NSArray!
    var townArray:NSArray!
    var selectedArray:NSArray!
 
    @IBOutlet weak var disribe: UITextField!

    @IBAction func submitInfo(_ sender: AnyObject) {
        let portraitImage = self.tumbbutton.currentBackgroundImage
        let portraitImageData = UIImageJPEGRepresentation(portraitImage!, 0.8)
        let portraitImageDataBase64Str: String? =  portraitImageData?.base64EncodedString(options: .lineLength64Characters)
        
        let data = [
           
            "sid": "154611075",
            "uname": (self.namecell.detailTextLabel?.text)! as String,
            "sex": (self.gendercell.detailTextLabel?.text)! as String,
            "hometown": (self.homecell.detailTextLabel?.text)! as String,
            "emostate": (self.relationcell.detailTextLabel?.text)! as String,
            "birthday": (self.birthcell.detailTextLabel?.text)! as String,
            "portraiturl": portraitImageDataBase64Str!
        ]
       
        let url = "http://115.29.140.140/Morph/IOSRegisterServlet"

        Alamofire.request(url, method: .post, parameters: data, encoding: URLEncoding.default, headers: nil).response { (response) in
            print(response)
        }
        ProgressHUD.showSuccess("\(self.namecell.textLabel?.text) 欢迎来到Morph")
        let saveUserInfoQueue = DispatchQueue(label: "saveUserInfoQueue", attributes: [])
        saveUserInfoQueue.async {
            //将信息保存至归档中，方便后面的页面进行本地读取
            let userInfo = UserInfo()
            if let id = UserDefaults.standard.value(forKey: "id") as? NSString{
                userInfo.sid = id as NSString
            }
            userInfo.uname = (self.namecell.detailTextLabel?.text)! as NSString
            userInfo.sex = (self.gendercell.detailTextLabel?.text)! as NSString
            userInfo.hometown = (self.homecell.detailTextLabel?.text)! as NSString
            userInfo.emostate = (self.relationcell.detailTextLabel?.text)! as NSString
            userInfo.birthday = (self.birthcell.detailTextLabel?.text)! as NSString
            userInfo.portrait = portraitImageData! as Data
            if(self.disribe.text == nil){
                userInfo.discribe = "站在风口的瞭望者"
            }else{
                userInfo.discribe = self.disribe.text! as NSString
            }
            userInfo.major = "信息院"
            let userData = NSKeyedArchiver.archivedData(withRootObject: userInfo)
            UserDefaults.standard.set(userData, forKey: "userinfo")
            print("用户信息保存成功")
            Thread.sleep(forTimeInterval: 2)
            DispatchQueue.main.async(execute: { 
                let mainTabViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabViewController")
                self.present(mainTabViewController!, animated: true, completion: nil)
            })
        }
    }
    @IBOutlet var tableview: UITableView!
    
    @IBOutlet weak var namecell: UITableViewCell!
    @IBOutlet weak var gendercell: UITableViewCell!
    @IBOutlet weak var homecell: UITableViewCell!
    @IBOutlet weak var relationcell: UITableViewCell!
    @IBOutlet weak var birthcell: UITableViewCell!
    @IBOutlet weak var tumbbutton: UIButton!
    @IBAction func tumbTap(_ sender: AnyObject) {
        let alertController = UIAlertController(title: "选取头像", message: "建议使用真实头像",preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        //        let deleteAction = UIAlertAction(title: "删除", style: .Destructive, handler: nil)
        let archiveAction = UIAlertAction(title: "相册", style: .default, handler:{action in
            //弹出一个系统相册选择器
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }})
        let archiveAction2 = UIAlertAction(title: "拍照", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        //alertController.addAction(deleteAction)
        alertController.addAction(archiveAction)
        alertController.addAction(archiveAction2)
        self.present(alertController, animated: true, completion: nil)
        
    }
    //设置选取的图片将其赋值给tumbbutton的image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       
        var image: UIImage!
        // 判断，图片是否允许修改
        if(picker.allowsEditing){
         //裁剪后图片
            image = info[UIImagePickerControllerEditedImage] as! UIImage
        }else{
            //原始图片
            image = info[UIImagePickerControllerOriginalImage] as! UIImage
            
        }
        self.tumbbutton.setBackgroundImage(image, for: UIControlState())
        self.tumbbutton.imageView?.contentMode = .center
        self.tumbbutton.imageView?.clipsToBounds = true
        
        dismiss(animated: true, completion: nil)
        
    }
    //用户取消选择相册时调用该方法
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    //从plist中读取数据到数组
    func getPickerData(){
        let path = Bundle.main.path(forResource: "address", ofType: "plist")
        self.pickerDic = NSDictionary.init(contentsOfFile: path!)!
        self.provinceArray = self.pickerDic.allKeys as NSArray!
        self.selectedArray = self.pickerDic.object(forKey: self.pickerDic.allKeys[0]) as! NSArray
        if(self.selectedArray.count > 0){
            self.cityArray = (self.selectedArray[0] as AnyObject).allKeys as NSArray!
        }
        if(self.cityArray.count > 0){
            self.townArray = (self.selectedArray[0] as! NSDictionary).object(forKey: self.cityArray[0]) as! NSArray!
//            self.townArray = (self.selectedArray[0] as AnyObject).object(self.cityArray[0]) as! NSArray
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.alpha = 0.9
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black]

        //先获取picker的数据
        getPickerData()
        self.tableview.tableFooterView = UIView(frame: CGRect.zero)
        self.tableview.delegate = self
        tumbbutton.imageView?.image = UIImage(named: "tumb2")
        tumbbutton.layer.cornerRadius = tumbbutton.frame.size.width/2
        tumbbutton.layer.borderWidth = 2
        tumbbutton.clipsToBounds = true
        tumbbutton.layer.borderColor = (UIColor.gray).cgColor
        
        namecell.detailTextLabel?.text = "小明"
//        gendercell.detailTextLabel?.text = ""
//        homecell.detailTextLabel?.text = ""
//        relationcell.detailTextLabel?.text = ""
//        birthcell.detailTextLabel?.text = ""
        
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //实现静态的tableviewcel被点击的方法
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //tableview.delegate = self
        //tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if (gendercell.isSelected == true) {
            let alertController = UIAlertController(title: "你是帅哥还是镁铝", message: "第三方性别请联系Morph管理员设置", preferredStyle: .actionSheet)
            let archiveAction1 = UIAlertAction(title: "女", style: .default, handler: {action in self.gendercell.detailTextLabel?.text = "女"
            self.gendercell.setSelected(false, animated: true)})
            let concelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let archiveAction = UIAlertAction(title: "男", style: .default, handler: {action in self.gendercell.detailTextLabel?.text = "男"
            self.gendercell.setSelected(false, animated: true)})
            alertController.addAction(archiveAction)
            alertController.addAction(archiveAction1)
            alertController.addAction(concelAction)

            self.present(alertController, animated: true, completion: nil)
        }else if(homecell.isSelected == true){
            //第二个alercontroller
            let alertController2 = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
            let concelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let archiveAction = UIAlertAction(title: "确定", style: .default, handler: {action in
                self.homecell.detailTextLabel?.text = (self.provinceArray[self.myPicker.selectedRow(inComponent: 0)] as? String)! + (self.cityArray[self.myPicker.selectedRow(inComponent: 1)] as? String)!
                self.homecell.setSelected(false, animated: true)
                })
            
            alertController2.addAction(archiveAction)
            alertController2.addAction(concelAction)
            //设置pickerview
            self.myPicker = UIPickerView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width*15/16, height: UIScreen.main.bounds.height/3))
            self.myPicker.center.x = alertController2.view.center.x
            self.myPicker.dataSource = self
            self.myPicker.delegate = self
            //将pickerview添加到alertcontroller中
            alertController2.view.addSubview(self.myPicker)
            self.present(alertController2, animated: true, completion: nil)
            self.homecell.setSelected(true, animated: true)
        }else if(relationcell.isSelected == true){
            //第三个alercontroller
            let alertController3 = UIAlertController(title: "设置情感状态", message: "设置情感状态更容易得到异性亲睐哦", preferredStyle: .actionSheet)
            let concelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let archiveAction = UIAlertAction(title: "单身", style: .default, handler: {action in
                self.relationcell.detailTextLabel?.text = "单身"
                self.relationcell.setSelected(false, animated: true)})
            let archiveAction2 = UIAlertAction(title: "热恋中", style: .default, handler: {action in
                self.relationcell.detailTextLabel?.text = "热恋中"
                self.relationcell.setSelected(false, animated: true)})
            let archiveAction3 = UIAlertAction(title: "保密", style: .default, handler: {action in
                self.relationcell.detailTextLabel?.text = "保密"
                self.relationcell.setSelected(false, animated: true)})
            alertController3.addAction(archiveAction3)
            alertController3.addAction(archiveAction2)
            alertController3.addAction(archiveAction)
            alertController3.addAction(concelAction)
            self.present(alertController3, animated: true, completion: nil)
        }else if(birthcell.isSelected == true){
            let datePicker = UIDatePicker()
            let dateLocal = Locale(identifier: "zh_CN")
            datePicker.locale = dateLocal
            datePicker.timeZone = TimeZone(identifier: "GMT")
            datePicker.datePickerMode = UIDatePickerMode.date
            datePicker.date = Date()
            //datePicker.addTarget(self, action: "setBirthCell:", forControlEvents: UIControlEvents.TouchUpInside)
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "yyyy-MM-dd"
            //Alercontroller第四个
            let alertController4 = UIAlertController(title: "\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
            alertController4.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: {action in
                self.birthcell.detailTextLabel?.text = dateFormat.string(from: datePicker.date)
                //print(dateFormat.stringFromDate(datePicker.date))
                self.birthcell.setSelected(false, animated: true)}))
            alertController4.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel,handler:nil))
            alertController4.view.addSubview(datePicker)
            self.present(alertController4, animated: true, completion: nil)
        }
        
          self.gendercell.setSelected(false, animated: true)
          self.homecell.setSelected(false, animated: true)
          self.relationcell.setSelected(false, animated: true)
          self.birthcell.setSelected(false, animated: true)
    }
    
    
    //pickerview实现的三个方法
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) ->Int{
        if(component == 0){
            return self.provinceArray.count
        }else if(component == 1){
            return self.cityArray.count
        }else{
            return self.townArray.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        if(component == 0){
            return self.provinceArray[row] as? String
        }else if(component == 1){
            return self.cityArray[row] as? String
        }else{
            return self.townArray[row] as? String
        }
    }
    //协议里的最后一个方法，实现三级联动控制
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if(component == 0){
            self.selectedArray = self.pickerDic.object(forKey: self.provinceArray[row]) as! NSArray
            if(self.selectedArray.count > 0){
                self.cityArray = (self.selectedArray[0] as AnyObject).allKeys as NSArray!
            }else{
                self.cityArray = nil
            }
            if(self.cityArray.count > 0){
                self.townArray = (self.selectedArray[0] as! NSDictionary).object(forKey: self.cityArray[0]) as! NSArray
            }else{
                self.townArray = nil
            }
        }
        pickerView.selectedRow(inComponent: 1)
        pickerView.reloadComponent(1)
        pickerView.selectedRow(inComponent: 2)
        
        if(component == 1){
            if(self.selectedArray.count > 0 && self.cityArray.count > 0){
                self.townArray = (self.selectedArray[0] as! NSDictionary).object(forKey: self.cityArray[row]) as! NSArray
            }else{
                self.townArray = nil
            }
            pickerView.selectRow(1, inComponent: 2, animated: true)
        }
        pickerView.reloadComponent(2)
    }
   
    @IBAction func close(_ segue: UIStoryboardSegue){
        if let NameInputTableViewController = segue.source as? NameInputTableViewController{
            let name = NameInputTableViewController.nameTextField.text
            if name != nil{
                self.namecell.detailTextLabel?.text = name!
                
            }
        }
        
    }
    
  
    
}

