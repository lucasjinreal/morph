//
//  MeTableViewController.swift
//  Morph
//
//  Created by JinTian on 4/16/16.
//  Copyright © 2016 JinTian. All rights reserved.
//
import UIKit

class MeTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    var myPicker:UIPickerView!
    var pickerDic:NSDictionary!
    var provinceArray:NSArray!
    var cityArray:NSArray!
    var townArray:NSArray!
    var selectedArray:NSArray!
    

    @IBOutlet var tableview: UITableView!
    
    @IBOutlet weak var namecell: UITableViewCell!
    @IBOutlet weak var gendercell: UITableViewCell!
    @IBOutlet weak var homecell: UITableViewCell!
    @IBOutlet weak var relationcell: UITableViewCell!
    @IBOutlet weak var birthcell: UITableViewCell!
    @IBOutlet weak var tumbbutton: UIButton!
    @IBAction func tumbTap(sender: AnyObject) {
        let alertController = UIAlertController(title: "选取头像", message: "建议使用真实头像",preferredStyle: .ActionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        //        let deleteAction = UIAlertAction(title: "删除", style: .Destructive, handler: nil)
        let archiveAction = UIAlertAction(title: "相册", style: .Default, handler:{action in
            //弹出一个系统相册选择器
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .PhotoLibrary
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }})
        let archiveAction2 = UIAlertAction(title: "拍照", style: .Default, handler: nil)
        alertController.addAction(cancelAction)
        //alertController.addAction(deleteAction)
        alertController.addAction(archiveAction)
        alertController.addAction(archiveAction2)
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    //设置选取的图片将其赋值给tumbbutton的image
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
       
        var image: UIImage!
        // 判断，图片是否允许修改
        if(picker.allowsEditing){
         //裁剪后图片
            image = info[UIImagePickerControllerEditedImage] as! UIImage
        }else{
            //原始图片
            image = info[UIImagePickerControllerOriginalImage] as! UIImage
            
        }
        self.tumbbutton.setBackgroundImage(image, forState: UIControlState.Normal)
        self.tumbbutton.imageView?.contentMode = .Center
        self.tumbbutton.imageView?.clipsToBounds = true
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    //用户取消选择相册时调用该方法
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    
    
    
    //从plist中读取数据到数组
    func getPickerData(){
        let path = NSBundle.mainBundle().pathForResource("address", ofType: "plist")
        self.pickerDic = NSDictionary.init(contentsOfFile: path!)!
        self.provinceArray = self.pickerDic.allKeys
        self.selectedArray = self.pickerDic.objectForKey(self.pickerDic.allKeys[0]) as! NSArray
        if(self.selectedArray.count > 0){
            self.cityArray = self.selectedArray[0].allKeys
        }
        if(self.cityArray.count > 0){
            self.townArray = self.selectedArray[0].objectForKey(self.cityArray[0]) as! NSArray
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.alpha = 0.9
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor()]

        //先获取picker的数据
        getPickerData()
        self.tableview.tableFooterView = UIView(frame: CGRectZero)
        self.tableview.delegate = self
        tumbbutton.imageView?.image = UIImage(named: "tumb2")
        tumbbutton.layer.cornerRadius = tumbbutton.frame.size.width/2
        tumbbutton.layer.borderWidth = 2
        tumbbutton.clipsToBounds = true
        tumbbutton.layer.borderColor = (UIColor.grayColor()).CGColor
        
        namecell.detailTextLabel?.text = "吴亦凡"
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
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        //tableview.delegate = self
        //tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if (gendercell.selected == true) {
            let alertController = UIAlertController(title: "你是帅哥还是镁铝", message: "第三方性别请联系Morph管理员设置", preferredStyle: .ActionSheet)
            let archiveAction1 = UIAlertAction(title: "女", style: .Default, handler: {action in self.gendercell.detailTextLabel?.text = "女"
            self.gendercell.setSelected(false, animated: true)})
            let concelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
            let archiveAction = UIAlertAction(title: "男", style: .Default, handler: {action in self.gendercell.detailTextLabel?.text = "男"
            self.gendercell.setSelected(false, animated: true)})
            alertController.addAction(archiveAction)
            alertController.addAction(archiveAction1)
            alertController.addAction(concelAction)

            self.presentViewController(alertController, animated: true, completion: nil)
        }else if(homecell.selected == true){
            //第二个alercontroller
            let alertController2 = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .ActionSheet)
            let concelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
            let archiveAction = UIAlertAction(title: "确定", style: .Default, handler: {action in
                self.homecell.detailTextLabel?.text = (self.provinceArray[self.myPicker.selectedRowInComponent(0)] as? String)! + (self.cityArray[self.myPicker.selectedRowInComponent(1)] as? String)!
                self.homecell.setSelected(false, animated: true)
                })
            
            alertController2.addAction(archiveAction)
            alertController2.addAction(concelAction)
            //设置pickerview
            self.myPicker = UIPickerView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width*15/16, height: UIScreen.mainScreen().bounds.height/3))
            self.myPicker.center.x = alertController2.view.center.x
            self.myPicker.dataSource = self
            self.myPicker.delegate = self
            //将pickerview添加到alertcontroller中
            alertController2.view.addSubview(self.myPicker)
            self.presentViewController(alertController2, animated: true, completion: nil)
            self.homecell.setSelected(true, animated: true)
        }else if(relationcell.selected == true){
            //第三个alercontroller
            let alertController3 = UIAlertController(title: "设置情感状态", message: "设置情感状态更容易得到异性亲睐哦", preferredStyle: .ActionSheet)
            let concelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
            let archiveAction = UIAlertAction(title: "单身", style: .Default, handler: {action in
                self.relationcell.detailTextLabel?.text = "单身"
                self.relationcell.setSelected(false, animated: true)})
            let archiveAction2 = UIAlertAction(title: "热恋中", style: .Default, handler: {action in
                self.relationcell.detailTextLabel?.text = "热恋中"
                self.relationcell.setSelected(false, animated: true)})
            let archiveAction3 = UIAlertAction(title: "保密", style: .Default, handler: {action in
                self.relationcell.detailTextLabel?.text = "保密"
                self.relationcell.setSelected(false, animated: true)})
            alertController3.addAction(archiveAction3)
            alertController3.addAction(archiveAction2)
            alertController3.addAction(archiveAction)
            alertController3.addAction(concelAction)
            self.presentViewController(alertController3, animated: true, completion: nil)
        }else if(birthcell.selected == true){
            let datePicker = UIDatePicker()
            let dateLocal = NSLocale(localeIdentifier: "zh_CN")
            datePicker.locale = dateLocal
            datePicker.timeZone = NSTimeZone(name: "GMT")
            datePicker.datePickerMode = UIDatePickerMode.Date
            datePicker.date = NSDate()
            //datePicker.addTarget(self, action: "setBirthCell:", forControlEvents: UIControlEvents.TouchUpInside)
            let dateFormat = NSDateFormatter()
            dateFormat.dateFormat = "yyyy-MM-dd"
            //Alercontroller第四个
            let alertController4 = UIAlertController(title: "\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .ActionSheet)
            alertController4.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: {action in
                self.birthcell.detailTextLabel?.text = dateFormat.stringFromDate(datePicker.date)
                //print(dateFormat.stringFromDate(datePicker.date))
                self.birthcell.setSelected(false, animated: true)}))
            alertController4.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel,handler:nil))
            alertController4.view.addSubview(datePicker)
            self.presentViewController(alertController4, animated: true, completion: nil)
        }
        
          self.gendercell.setSelected(false, animated: true)
          self.homecell.setSelected(false, animated: true)
          self.relationcell.setSelected(false, animated: true)
          self.birthcell.setSelected(false, animated: true)
    }
    
    
    //pickerview实现的三个方法
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 3
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) ->Int{
        if(component == 0){
            return self.provinceArray.count
        }else if(component == 1){
            return self.cityArray.count
        }else{
            return self.townArray.count
        }
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        if(component == 0){
            return self.provinceArray[row] as? String
        }else if(component == 1){
            return self.cityArray[row] as? String
        }else{
            return self.townArray[row] as? String
        }
    }
    //协议里的最后一个方法，实现三级联动控制
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if(component == 0){
            self.selectedArray = self.pickerDic.objectForKey(self.provinceArray[row]) as! NSArray
            if(self.selectedArray.count > 0){
                self.cityArray = self.selectedArray[0].allKeys
            }else{
                self.cityArray = nil
            }
            if(self.cityArray.count > 0){
                self.townArray = self.selectedArray[0].objectForKey(self.cityArray[0]) as! NSArray
            }else{
                self.townArray = nil
            }
        }
        pickerView.selectedRowInComponent(1)
        pickerView.reloadComponent(1)
        pickerView.selectedRowInComponent(2)
        
        if(component == 1){
            if(self.selectedArray.count > 0 && self.cityArray.count > 0){
                self.townArray = self.selectedArray[0].objectForKey(self.cityArray[row]) as! NSArray
            }else{
                self.townArray = nil
            }
            pickerView.selectRow(1, inComponent: 2, animated: true)
        }
        pickerView.reloadComponent(2)
    }
   
    @IBAction func close(segue: UIStoryboardSegue){
        if let NameInputTableViewController = segue.sourceViewController as? NameInputTableViewController{
            let name = NameInputTableViewController.nameTextField.text
            if name != nil{
                self.namecell.detailTextLabel?.text = name!
                
            }
        }
        
    }
    
  
    
}

