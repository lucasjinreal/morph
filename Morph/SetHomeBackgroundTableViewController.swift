//
//  SetHomeBackgroundTableViewController.swift
//  Morph
//
//  Created by JinTian on 16/11/2016.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class SetHomeBackgroundTableViewController: UITableViewController {

    @IBOutlet var setBkTableView: UITableView!
    
    @IBOutlet weak var bk1: UIImageView!
    @IBOutlet weak var bk2: UIImageView!
    var chooseImage: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bk1.isUserInteractionEnabled = true
        let tapBk1 = UITapGestureRecognizer(target: self, action: #selector(SetHomeBackgroundTableViewController.chooseBk1))
        self.bk1.addGestureRecognizer(tapBk1)
        
        self.bk2.isUserInteractionEnabled = true
        let tapBk2 = UITapGestureRecognizer(target: self, action: #selector(SetHomeBackgroundTableViewController.chooseBk2))
        self.bk2.addGestureRecognizer(tapBk2)
    

      
    }
    func chooseBk1(){
        self.chooseImage = self.bk1.image
        let sb = UIStoryboard.init(name: "Find", bundle: Bundle.main)
        let chooseVC = sb.instantiateViewController(withIdentifier: "ChooseHomeBackgroundViewController") as! ChooseHomeBackgroundViewController
        chooseVC.choosedImage = self.chooseImage
        self.present(chooseVC, animated: true, completion: nil)
        
    }
    func chooseBk2(){
        self.chooseImage = self.bk2.image
        let sb = UIStoryboard.init(name: "Find", bundle: Bundle.main)
        let chooseVC = sb.instantiateViewController(withIdentifier: "ChooseHomeBackgroundViewController") as! ChooseHomeBackgroundViewController
        chooseVC.choosedImage = self.chooseImage
        self.present(chooseVC, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.setBkTableView.deselectRow(at: indexPath, animated: true)
    }


}
