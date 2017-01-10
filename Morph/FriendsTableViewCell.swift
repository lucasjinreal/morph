//
//  FriendsTableViewCell.swift
//  Morph
//
//  Created by JinTian on 15/10/2016.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var portrait: UIImageView!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.portrait.layer.cornerRadius = self.portrait.frame.width/2
        self.portrait.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var friendsList: FriendsListModal?{
        didSet{
            if friendsList != nil{
                self.setupUI()
            }
        }
    }
    
    func setupUI(){
        self.portrait.image = friendsList?.portrait
        self.name.text = friendsList?.name
        
    }

}
