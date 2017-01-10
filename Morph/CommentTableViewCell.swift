//
//  CommentTableViewCell.swift
//  Morph
//
//  Created by JinTian on 8/5/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var commentcontent: UILabel!
    @IBOutlet weak var commenttime: UILabel!
    
    @IBOutlet weak var replytableviewheight: NSLayoutConstraint!
    @IBOutlet weak var replytableview: UITableView!

    var comment: CommentModal?{
        didSet{
            if comment != nil{
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
        
        self.commentcontent.numberOfLines = 0
        
        self.replytableview.dataSource = self
        self.replytableview.delegate = self
        self.replytableview.rowHeight = UITableViewAutomaticDimension
        self.replytableview.estimatedRowHeight = 100
        self.replytableview.reloadData()
        self.replytableviewheight.constant = 200
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupUI(){
        self.avatar.image = comment?.avatar
        self.name.text = comment?.username
        self.commentcontent.text = comment?.commentcontent
        self.commenttime.text = comment?.commenttime
    }
    
}

extension CommentTableViewCell: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if comment?.replyarray!.count != nil{
            return (comment?.replyarray?.count)!
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.replytableview.dequeueReusableCell(withIdentifier: "ReplyCell")! as! ReplyTableViewCell
        cell.replylabel.text = comment?.replyarray! [indexPath.row]
        return cell
    }
}
