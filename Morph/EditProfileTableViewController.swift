//
//  EditProfileTableViewController.swift
//  Morph
//
//  Created by JinTian on 10/11/2016.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class EditProfileTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var myThumb: UIButton!
    @IBOutlet weak var majorCell: UITableViewCell!
    @IBOutlet weak var homeCell: UITableViewCell!
    @IBOutlet weak var birthCell: UITableViewCell!
    @IBOutlet weak var relationCell: UITableViewCell!
    @IBOutlet weak var genderCell: UITableViewCell!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var discribeTextField: UITextField!
    @IBOutlet weak var dateanounceTextFiled: UITextField!
    @IBOutlet weak var majorPicker: UIPickerView!
    @IBOutlet weak var majorPickerCell: UITableViewCell!
    @IBOutlet weak var homePickerCell: UITableViewCell!
    @IBOutlet weak var homePicker: UIPickerView!
    
    @IBOutlet weak var datePickerCell: UITableViewCell!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var isMajorExpand: Bool = false
    var isBirthExpand: Bool = false
    var isHomeExpand: Bool = false
    
    var schoolArray: NSArray!
    var majorArray: NSArray!
    var majorDict: NSDictionary!
    
    var homeDict:NSDictionary!
    var provinceArray:NSArray!
    var cityArray:NSArray!
    var townArray:NSArray!
    var selectedArray:NSArray!
    
    @IBAction func didTapSave(_ sender: AnyObject) {
        ProgressHUD.showSuccess("修改成功ヽ(^o^)丿")
        DispatchQueue.main.async {
            let userInfo = UserInfo()
            if let id = UserDefaults.standard.value(forKey: "id") as? NSString{
                userInfo.sid = id as NSString
            }
            userInfo.uname = (self.nameTextField.text)! as NSString
            userInfo.sex = (self.genderCell.detailTextLabel?.text)! as NSString
            userInfo.hometown = (self.homeCell.detailTextLabel?.text)! as NSString
            userInfo.emostate = (self.relationCell.detailTextLabel?.text)! as NSString
            userInfo.birthday = (self.birthCell.detailTextLabel?.text)! as NSString
            let image = self.myThumb.currentBackgroundImage
            let imageData = UIImageJPEGRepresentation(image!, 0.8)
            userInfo.portrait = imageData! as Data
            if(self.discribeTextField.text == nil){
                userInfo.discribe = "站在风口的瞭望者"
            }else{
                userInfo.discribe = self.discribeTextField.text! as NSString
            }
            userInfo.major = (self.majorCell.detailTextLabel?.text)! as NSString
            userInfo.dateanounce = self.dateanounceTextFiled.text! as NSString
            let userData = NSKeyedArchiver.archivedData(withRootObject: userInfo)
            UserDefaults.standard.set(userData, forKey: "userinfo")
//            ProgressHUD.dismiss()
        }

    }
    
    @IBAction func didTapThumb(_ sender: AnyObject) {
        let alertController = UIAlertController(title: "更换头像", message: "选择一张照片",preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
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
        self.myThumb.setBackgroundImage(image, for: UIControlState())
        self.myThumb.imageView?.contentMode = .center
        self.myThumb.imageView?.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }
    //用户取消选择相册时调用该方法
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.myThumb.layer.cornerRadius = self.myThumb.frame.height/2
        self.myThumb.layer.masksToBounds = true
        self.myThumb.layer.borderColor = UIColor.white.cgColor
        self.myThumb.layer.borderWidth = 2
        self.majorPicker.dataSource = self
        self.majorPicker.delegate = self
        
        self.homePicker.dataSource = self
        self.homePicker.delegate = self
        
        self.getMajorPickerData()
        self.getHomePickerData()
        if let userData = UserDefaults.standard.object(forKey: "userinfo") as? Data{
            if let userinfo = NSKeyedUnarchiver.unarchiveObject(with: userData) as? UserInfo{
                let imageData = userinfo.portrait
                let image = UIImage(data: imageData! as Data)
                self.myThumb.setBackgroundImage(image, for: UIControlState())
                self.nameTextField.text = userinfo.uname as? String
                self.discribeTextField.text = userinfo.discribe as? String
                self.genderCell.detailTextLabel?.text = userinfo.sex as? String
                self.majorCell.detailTextLabel?.text = userinfo.major as? String
                self.homeCell.detailTextLabel?.text = userinfo.hometown as? String
                self.birthCell.detailTextLabel?.text = userinfo.birthday as? String
                self.relationCell.detailTextLabel?.text = userinfo.emostate as? String
                self.dateanounceTextFiled.text = userinfo.dateanounce as? String
            }
        }
        
    }
    
    func getMajorPickerData(){
        //两级联动的基本思想就是先假设用户选择了一个component然后第二个会是啥，后面再pickerview的delegate中再改变
        let path = Bundle.main.path(forResource: "Major", ofType: "plist")
        self.majorDict = NSDictionary.init(contentsOfFile: path!)
        self.schoolArray = majorDict?.allKeys as NSArray!
        self.majorArray = majorDict?.object(forKey: (majorDict?.allKeys[0])!) as! NSArray
        
    }
    func getHomePickerData(){
        let path = Bundle.main.path(forResource: "address", ofType: "plist")
        self.homeDict = NSDictionary.init(contentsOfFile: path!)!
        self.provinceArray = self.homeDict.allKeys as NSArray!
        self.selectedArray = self.homeDict.object(forKey: self.homeDict.allKeys[0]) as! NSArray
        if(self.selectedArray.count > 0){
            self.cityArray = (self.selectedArray[0] as AnyObject).allKeys as NSArray!
        }
        if(self.cityArray.count > 0){
            self.townArray = (self.selectedArray[0] as! NSDictionary).object(forKey: self.cityArray[0]) as! NSArray
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(self.majorCell.isSelected == true){
            if(isMajorExpand){
                self.isMajorExpand = false
                self.majorCell.detailTextLabel?.textColor = UIColor.darkGray
            }else{
                self.isMajorExpand = true
                self.majorCell.detailTextLabel?.textColor = UIColor.red
            }
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
        if(self.homeCell.isSelected == true){
            if(isHomeExpand){
                self.isHomeExpand = false
                self.homeCell.detailTextLabel?.textColor = UIColor.darkGray
            }else{
                self.isHomeExpand = true
                self.homeCell.detailTextLabel?.textColor = UIColor.red
            }
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
        if(self.birthCell.isSelected == true){
            if(isBirthExpand){
                self.isBirthExpand = false
                self.birthCell.detailTextLabel?.textColor = UIColor.darkGray
            }else{
                self.isBirthExpand = true
                self.birthCell.detailTextLabel?.textColor = UIColor.red
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self.birthCell.detailTextLabel?.text = dateFormatter.string(from: self.datePicker.date)
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
        if (self.relationCell.isSelected == true) {
            let alertController3 = UIAlertController(title: "设置情感状态", message: "设置情感状态更容易得到异性亲睐哦", preferredStyle: .actionSheet)
            let concelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let archiveAction = UIAlertAction(title: "单身", style: .default, handler: {action in
                self.relationCell.detailTextLabel?.text = "单身"
                self.relationCell.setSelected(false, animated: true)})
            let archiveAction2 = UIAlertAction(title: "热恋中", style: .default, handler: {action in
                self.relationCell.detailTextLabel?.text = "热恋中"
                self.relationCell.setSelected(false, animated: true)})
            let archiveAction3 = UIAlertAction(title: "保密", style: .default, handler: {action in
                self.relationCell.detailTextLabel?.text = "保密"
                self.relationCell.setSelected(false, animated: true)})
            alertController3.addAction(archiveAction3)
            alertController3.addAction(archiveAction2)
            alertController3.addAction(archiveAction)
            alertController3.addAction(concelAction)
            self.present(alertController3, animated: true, completion: nil)
        }
        if (self.genderCell.isSelected == true) {
            let alertController = UIAlertController(title: "修改性别", message: "第三方性别请联系Morph管理员设置", preferredStyle: .actionSheet)
            let archiveAction1 = UIAlertAction(title: "女", style: .default, handler: {action in self.genderCell.detailTextLabel?.text = "女"
                self.genderCell.setSelected(false, animated: true)})
            let concelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let archiveAction = UIAlertAction(title: "男", style: .default, handler: {action in self.genderCell.detailTextLabel?.text = "男"
                self.genderCell.setSelected(false, animated: true)})
            alertController.addAction(archiveAction)
            alertController.addAction(archiveAction1)
            alertController.addAction(concelAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        self.tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 4){
            if(isMajorExpand){
                return 200
            }else{
                return 0
            }
            
        }else if(indexPath.row == 6){
            if(isHomeExpand){
                return 200
            }else{
                return 0
            }
        }else if(indexPath.row == 8){
            if (isBirthExpand) {
                return 200
            }else{
                return 0
            }
        }else{
            return tableView.rowHeight
        }
    }   
}
extension EditProfileTableViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if (pickerView == self.homePicker) {
            return 3
        }else{
            return 2
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == self.homePicker){
            if(component == 0){
                return self.provinceArray.count
            }else if(component == 1){
                return self.cityArray.count
            }else{
                return self.townArray.count
            }
        }else{
            if(component == 0){
                return self.schoolArray.count
            }else{
                return self.majorArray.count
            }
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView == self.homePicker){
            if(component == 0){
                return self.provinceArray[row] as? String
            }else if(component == 1){
                return self.cityArray[row] as? String
            }else{
                return self.townArray[row] as? String
            }
        }else{
            if (component == 0) {
                return self.schoolArray[row] as? String
            }else{
                return self.majorArray[row] as? String
            }
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView == self.homePicker){
            if(component == 0){
                self.selectedArray = self.homeDict.object(forKey: self.provinceArray[row]) as! NSArray
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
            self.homeCell.detailTextLabel?.text = self.provinceArray[self.homePicker.selectedRow(inComponent: 0)] as! String + (self.cityArray[self.homePicker.selectedRow(inComponent: 1)] as! String) + (self.townArray[self.homePicker.selectedRow(inComponent: 2)] as! String)
        }else{
            if(component == 0){
                self.majorArray = self.majorDict.object(forKey: self.schoolArray[row]) as! NSArray
            }
            pickerView.reloadComponent(1)
            self.majorCell.detailTextLabel?.text = (self.schoolArray[self.majorPicker.selectedRow(inComponent: 0)] as! String) + (self.majorArray[self.majorPicker.selectedRow(inComponent: 1)] as! String)
        }
    }
}
