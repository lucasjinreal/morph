//
//  ChatlistTableViewCell.swift
//  Morph
//
//  Created by JinTian on 4/25/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class ChatlistTableViewCell: UITableViewCell {

    @IBOutlet weak var portrait: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var chatcontent: UILabel!
    @IBOutlet weak var time: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
