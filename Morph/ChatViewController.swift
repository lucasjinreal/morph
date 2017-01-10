//
//  ChatViewController.swift
//  Morph
//
//  Created by JinTian on 4/25/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    var chatlist_array:NSArray = []
    var chatlist: [ChatListModal?] = []
    
    var targetid: String?
    
    @IBOutlet weak var nodatabackgroundview: UILabel!
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView()
        tableview.register(UINib(nibName: "ChatlistTableViewCell", bundle: nil), forCellReuseIdentifier: "chatlistcell")
        
        chatlist_array = RCIMClient.shared().getConversationList([RCConversationType.ConversationType_PRIVATE.rawValue]) as NSArray
        for i in 0..<chatlist_array.count{
            let chat_row = chatlist_array[i] as! RCConversation
            
            var contenttext = ""
            if let lastestmessage = chat_row.lastestMessage{
                if lastestmessage.isKind(of: RCTextMessage.self){
                    contenttext = (lastestmessage as! RCTextMessage).content
                }
                if lastestmessage.isKind(of: RCImageMessage.self){
                    contenttext = "[图片]"
                }
                
            }
            
            let formatter = DateFormatter()
            let received_time =  Date.init(timeIntervalSince1970: Double(chat_row.receivedTime)/1000)
            formatter.dateFormat = "HH: mm"
            let time = formatter.string(from: received_time)
            
            let chat = ChatListModal(portrait: UIImage(named: "f_2"), name: chat_row.targetId, contenttext: contenttext, time: time)
            self.chatlist.append(chat)
        }
        debugPrint(chatlist.count)
        self.tableview.reloadData()
        self.nodatabackgroundview.isHidden = true
    
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.barStyle = .default
        
    }
    //Mark:Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toconversation"{
           let conversationvc = segue.destination as! ConversationViewController
            conversationvc.kJSQAvatarDisplayNameTa = self.targetid!
            debugPrint(targetid)
        }
    }
    
}



extension ChatViewController: UITableViewDelegate, UITableViewDataSource{
    //实现没有数据的时候显示没有数据的label标签
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if chatlist.count != 0{
            self.nodatabackgroundview.isHidden = true
            self.tableview.separatorStyle = .singleLine
            self.tableview.backgroundView = nil
            return chatlist.count
        }else{
            self.nodatabackgroundview.isHidden = false
            self.tableview.separatorStyle = .none
            self.tableview.backgroundView = self.nodatabackgroundview
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = self.tableview.dequeueReusableCell(withIdentifier: "chatlistcell", for: indexPath) as! ChatlistTableViewCell
    
        cell.chatlist = chatlist[indexPath.row]
        
        return cell
    }
    
    //Mark-UITableView Delet
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == UITableViewCellEditingStyle.delete{
            self.chatlist.remove(at: indexPath.row)
            self.tableview.deleteRows(at: [indexPath], with:UITableViewRowAnimation.middle)
            self.tableview.reloadData()
            
        }
    }
    
    //Mark-Did Select
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let chat_row = chatlist_array[indexPath.row] as! RCConversation
        targetid = chat_row.targetId
        self.performSegue(withIdentifier: "toconversation", sender: self)
        self.tableview.deselectRow(at: indexPath, animated: true)
 
    }
}

extension ChatViewController: RCIMClientReceiveMessageDelegate{
    func onReceived(_ message: RCMessage!, left nLeft: Int32, object: Any!) {
        if nLeft != 0 {
            debugPrint("...发了消息了吗.")
        }else{
            debugPrint("left收到消息多少条了吗\(nLeft)")
            
        }
    }
}





