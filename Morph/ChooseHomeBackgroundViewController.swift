//
//  ChooseHomeBackgroundViewController.swift
//  Morph
//
//  Created by JinTian on 17/11/2016.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class ChooseHomeBackgroundViewController: UIViewController {

    @IBOutlet weak var previewImage: UIImageView!
    var choosedImage: UIImage?
    
    @IBAction func didTapSet(_ sender: AnyObject) {
        
        
        ProgressHUD.showSuccess("设置成功")
        let saveBkQueue = DispatchQueue(label: "saveBkQueue", attributes: [])
        saveBkQueue.async { 
            let imageData = UIImagePNGRepresentation(self.choosedImage!)! as Data
            UserDefaults.standard.setValue(imageData, forKey: "homeBackground")
            Thread.sleep(forTimeInterval: 1)
            DispatchQueue.main.async(execute: { 
                self.dismiss(animated: true, completion: nil)
            })
        }
        
    }
    @IBAction func didTapCancel(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.choosedImage != nil {
            self.previewImage.image = self.choosedImage
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
