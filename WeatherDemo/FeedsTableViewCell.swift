//
//  FeedsTableViewCell.swift
//  WeatherDemo
//
//  Created by JinTian on 3/29/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class FeedsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var tablebackview: UIView!
    @IBOutlet weak var labeltitle: UILabel!
    @IBOutlet weak var pic: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.tablebackview.layer.cornerRadius = 15
        self.pic.layer.cornerRadius = self.pic.frame.width/2
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
