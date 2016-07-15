//
//  Setup2HomeViewController.swift
//  Morph
//
//  Created by JinTian on 4/19/16.
//  Copyright © 2016 JinTian. All rights reserved.
//
import UIKit

class Setup2HomeViewController: UIViewController {

   
    
    
    @IBOutlet weak var homepicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}
extension Setup2HomeViewController: UIPickerViewDataSource{
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 3
    }
   
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return 3
    }

}
extension Setup2HomeViewController: UIPickerViewDelegate{
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
       return "zhongguo"
    }
}