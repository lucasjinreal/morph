//
//  SetupViewController.swift
//  Morph
//
//  Created by JinTian on 4/10/16.
//  Copyright © 2016 JinTian. All rights reserved.
//
import UIKit
import LTMorphingLabel

class SetupViewController: UIViewController, LTMorphingLabelDelegate{

    private var i = -1
    private var textArray = [
        "And how it is like?",
        "What it is taste?",
        "How can I change it?",
        "Simple  Pure  Passion"
    ]
    private var text: String {
        i = i >= textArray.count - 1 ? 0 : i + 1
        return textArray[i]
    }

    
    @IBOutlet weak var displaybutton: UIButton!
    @IBAction func closepress(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBOutlet weak var setupbk: UIImageView!
    @IBOutlet weak var label: LTMorphingLabel!
    @IBAction func changeText(sender: AnyObject) {
        label.text = text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
//        self.navigationController?.navigationBar.alpha = 0.9
//        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        
//        let blurEffect = UIBlurEffect(style: .Light)
//        let effectView = UIVisualEffectView(effect: blurEffect)
//        effectView.frame = self.view.frame
//        setupbk.addSubview(effectView)
       
        

        self.displaybutton.layer.cornerRadius = 25
        self.displaybutton.layer.borderWidth = 0.5
        self.displaybutton.layer.borderColor = UIColor.blackColor().CGColor
        let item = UIBarButtonItem(title: " ", style: .Plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
        label.text = "What is life?"
        let effect = LTMorphingEffect(rawValue: 0)
        label.morphingEffect = effect!
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

//extension SetupViewController {
//    
//    func morphingDidStart(label: LTMorphingLabel) {
//        
//    }
//    
//    func morphingDidComplete(label: LTMorphingLabel) {
//        
//    }
//    
//    func morphingOnProgress(label: LTMorphingLabel, progress: Float) {
//        
//    }
//    
//}
//
