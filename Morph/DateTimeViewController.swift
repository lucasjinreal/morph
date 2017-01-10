//
//  DateTimeViewController.swift
//  Morph
//
//  Created by JinTian on 7/12/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit


typealias MyClosureDateTime = (_ str:String) -> Void
class DateTimeViewController: UIViewController {

    @IBOutlet weak var starttimepicker: UIDatePicker!
    @IBOutlet weak var endtimepicker: UIDatePicker!
    @IBOutlet weak var starttimeview: UIView!
    @IBOutlet weak var endtimeview: UIView!
    @IBOutlet weak var starttimelabel: UILabel!
    @IBOutlet weak var endtimelabel: UILabel!
    @IBOutlet weak var donebutton: UIButton!
    
    var starttime = ""
    var endtime = ""
    var sendstr = ""
    var myclosuredatetime: MyClosureDateTime?
    
    @IBAction func didTapDone(_ sender: AnyObject) {
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.starttimeview.layer.cornerRadius = 10
        self.endtimeview.layer.cornerRadius = 10
        
        self.donebutton.layer.borderWidth = 0.5
        self.donebutton.layer.cornerRadius = 18
        self.donebutton.layer.borderColor = UIColor.red.cgColor
        
        self.starttimelabel.layer.borderWidth = 0.5
        self.starttimelabel.layer.cornerRadius = 20
        self.starttimelabel.layer.borderColor = UIColor.red.cgColor
        self.endtimelabel.layer.borderWidth = 0.5
        self.endtimelabel.layer.cornerRadius = 20
        self.endtimelabel.layer.borderColor = UIColor.red.cgColor
        
        self.starttimepicker.addTarget(self, action: #selector(DateTimeViewController.starttimechanged), for: UIControlEvents.valueChanged)
        
        self.endtimepicker.addTarget(self, action: #selector(DateTimeViewController.endtimechanged(_:)), for: UIControlEvents.valueChanged)
        
    }
    func changetimetext(_ closure: @escaping MyClosureDateTime){
        myclosuredatetime = closure
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.sendstr = starttime + "到" + endtime
        myclosuredatetime!(self.sendstr)
        
    }
    
    func starttimechanged(_ datepicker: UIDatePicker){
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "MM.dd HH:mm"
        self.starttime = formatter.string(from: datepicker.date)
        self.starttimelabel.text = starttime
        
        
    }
    
    func endtimechanged(_ datepicker: UIDatePicker){
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "MM.dd HH:mm"
        self.endtime = formatter.string(from: datepicker.date)
        self.endtimelabel.text = endtime
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
