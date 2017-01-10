//
//  ReplyTableViewCell.swift
//  Morph
//
//  Created by JinTian on 8/5/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class ReplyTableViewCell: UITableViewCell {
    @IBOutlet weak var replylabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.replylabel.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
