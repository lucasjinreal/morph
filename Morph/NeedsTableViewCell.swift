//
//  NeedsTableViewCell.swift
//  Morph
//
//  Created by JinTian on 8/6/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class NeedsTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var needtitle: UILabel!
    @IBOutlet weak var needname: UILabel!
    @IBOutlet weak var needdiscription: UILabel!
    @IBOutlet weak var needmoney: UILabel!
    @IBOutlet weak var needtime: UILabel!
    
    var need: NeedModal?{
        didSet{
            if need != nil{
              setupUI()
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.avatar.layer.cornerRadius = self.avatar.frame.width/2
        self.avatar.layer.borderWidth = 2
        self.avatar.layer.borderColor = UIColor.white.cgColor
        self.avatar.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(){
        self.avatar.image = need?.avatar
        self.needtitle.text = need?.needtitle
        self.needname.text = need?.needname
        self.needdiscription.text = need?.needdiscription
        //self.needdiscription.numberOfLines = 0
        self.needmoney.text = need?.needmoney
        self.needtime.text = need?.needtime
    }

}
