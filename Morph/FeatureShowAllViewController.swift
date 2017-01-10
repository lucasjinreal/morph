//
//  FeatureShowAllViewController.swift
//  Morph
//
//  Created by JinTian on 6/4/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class FeatureShowAllViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

   
    
    
    @IBOutlet weak var showalltableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showalltableview.delegate = self
        self.showalltableview.dataSource = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}

extension FeatureShowAllViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 8
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = self.showalltableview.dequeueReusableCell(withIdentifier: "featureshowallcell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = "测试"
        return cell
    }

}
