//
//  DatePopupViewController.swift
//  Morph
//
//  Created by JinTian on 7/10/16.
//  Copyright © 2016 JinTian. All rights reserved.
//
import UIKit

class DatePopupViewController: UIViewController, PopupContentViewController {

   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.layer.cornerRadius = 4
    }
    
    func sizeForPopup(_ popupController: PopupController, size: CGSize, showingKeyboard: Bool) -> CGSize {
        return CGSize(width: 300, height: 500)
    }


    class func instance() -> DatePopupViewController{
        let storyboard = UIStoryboard(name: "DatePopupViewController", bundle: nil)
        return storyboard.instantiateInitialViewController() as! DatePopupViewController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}


