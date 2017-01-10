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
        self.portrait.layer.cornerRadius = self.portrait.frame.size.width/2
        self.portrait.clipsToBounds = true
        self.portrait.layer.borderWidth = 1.5
        self.portrait.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    var chatlist: ChatListModal?{
        didSet{
            if chatlist != nil{
                setupUI()
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(){
        self.portrait.image = chatlist?.portrait
        self.username.text = chatlist?.name
        self.chatcontent.text = chatlist?.contenttext
        self.time.text = chatlist?.time
    }
    
}
