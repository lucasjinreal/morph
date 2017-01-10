//
//  ViewController.swift
//  Mirro
//
//  Created by JinTian on 5/3/16.
//  Copyright © 2016 JinTian. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class ConversationViewController: JSQMessagesViewController{
    
    var kJSQAvatarDisplayNameTa: String = ""
    var kJSQAvatarDisplayNameMe: String = ""
    
    var kJSQAvatarIdTa: String = ""
    var kJSQAvatarIdMe: String = ""
    var messages : [JSQMessage] = []
    var avatars  : Dictionary< String, JSQMessagesAvatarImage>?
    var users    : Dictionary< String, String>?
    
    var outgoingBubbleImageData : JSQMessagesBubbleImage!
    var incomingBubbleImageData : JSQMessagesBubbleImage!
    
    // This value replace kJSQMessagesCollectionViewAvatarSizeDefault which lead to some trouble with swift type system
    let messagesCollectionViewAvatarSizeDefault = UInt(kJSQMessagesCollectionViewAvatarSizeDefault)
    
    var chatPeopleInfo: PeopleModal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadConversationInfo()
        self.create_bubble_image_objects()
        //设置融云的delegate
        RCIMClient.shared().setReceiveMessageDelegate(self, object: nil)
    }
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionView!.collectionViewLayout.springinessEnabled = true
    }
    //初始化聊天信息，包括双方头像、显示姓名等等
    func loadConversationInfo(){
        var meImage: JSQMessagesAvatarImage?
        var taImage: JSQMessagesAvatarImage?
        if let userData = UserDefaults.standard.object(forKey: "userinfo") as? Data{
            if let userinfo = NSKeyedUnarchiver.unarchiveObject(with: userData) as? UserInfo{
                let imageData = userinfo.portrait
                meImage = JSQMessagesAvatarImageFactory.avatarImage( with: UIImage(data: imageData!) , diameter:messagesCollectionViewAvatarSizeDefault )
                self.kJSQAvatarDisplayNameMe = (userinfo.uname as? String)!
                self.kJSQAvatarIdMe = (userinfo.sid as? String)!
            }
        }
        if self.chatPeopleInfo != nil {
            self.kJSQAvatarDisplayNameTa = (chatPeopleInfo?.uname as? String)!
            self.kJSQAvatarIdTa = (chatPeopleInfo?.sid as? String)!
            taImage = JSQMessagesAvatarImageFactory.avatarImage(with: UIImage(data: (self.chatPeopleInfo?.portrait)!) , diameter:messagesCollectionViewAvatarSizeDefault )
        }
        //id不能相等，否则界面不知道该用哪个id
        if kJSQAvatarIdMe != kJSQAvatarIdTa{
            self.users   = [kJSQAvatarIdMe : kJSQAvatarDisplayNameMe,
                            kJSQAvatarIdTa : kJSQAvatarDisplayNameTa]
            self.avatars = [kJSQAvatarIdTa : taImage!,
                            kJSQAvatarIdMe : meImage!]

        }else{
            let alertvc = UIAlertController(title: "提示", message: "请勿自己给自己发消息", preferredStyle: .alert)
            let action = UIAlertAction(title: "确定", style: .default, handler: { (action) in
                self.navigationController?.popViewController(animated: true)
            })
            alertvc.addAction(action)
            self.present(alertvc, animated: true, completion: nil)
        }
        self.title = kJSQAvatarDisplayNameTa
        self.senderId = kJSQAvatarIdMe
        self.senderDisplayName = kJSQAvatarDisplayNameMe
        self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize(width: 30, height: 30)
        self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize(width: 30, height: 30)
    }
    
    func reloadMessagesView() {
        self.collectionView?.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    func create_bubble_image_objects() {
        
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        
        self.outgoingBubbleImageData = bubbleFactory?.outgoingMessagesBubbleImage( with: UIColor.jsq_messageBubbleBlue())
        self.incomingBubbleImageData = bubbleFactory?.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleGreen())
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
    
    
}

extension ConversationViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: NSIndexPath!) -> JSQMessageData! {
        let data = self.messages[indexPath.row]
        return data
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didDeleteMessageAt indexPath: IndexPath!) {
        self.messages.remove(at: indexPath.row)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message: JSQMessage! = self.messages[indexPath.item]
        if message.senderId == self.senderId{
            return self.outgoingBubbleImageData
        }else{
            return self.incomingBubbleImageData
        }
    }
    
    override  func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource? {
        
        let message : JSQMessage = self.messages[indexPath.item]
        
        return self.avatars![message.senderId]
    }
    
    //发送方法
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        let send_message = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
        let send_message1 = RCTextMessage(content: send_message?.text)
        RCIMClient.shared().sendMessage(.ConversationType_PRIVATE, targetId: self.kJSQAvatarIdTa, content: send_message1, pushContent: nil, success: { (success) in
                debugPrint("发送成功了!!!!")
            }) { (error, messageId) in
                debugPrint("发送失败\(messageId)")
        }
        
        self.messages.append(send_message!)
        self.finishSendingMessage(animated: true)
        self.reloadMessagesView()
    }
    
    override func didPressAccessoryButton(_ sender: UIButton!) {
        
        let alertController = UIAlertController(title: "选择发送的内容", message: nil, preferredStyle: .actionSheet)
        let concelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let archiveAction1 = UIAlertAction(title: "发送图片", style: .default, handler: {actiion in
        })
        let archiveAction2 = UIAlertAction(title: "发送位置", style: .default, handler: {action in
        })
        let archiveAction3 = UIAlertAction(title: "发送文件", style: .default, handler: {action in
        })
        alertController.addAction(archiveAction1)
        alertController.addAction(archiveAction2)
        alertController.addAction(archiveAction3)
        alertController.addAction(concelAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    //添加时间标签
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForCellBottomLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        let message: JSQMessage = self.messages[indexPath.item]
        
        return JSQMessagesTimestampFormatter.shared().attributedTimestamp(for: message.date)
    }
    //不同地方的点击实现方法
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, header headerView: JSQMessagesLoadEarlierHeaderView!, didTapLoadEarlierMessagesButton sender: UIButton!) {
        NSLog("Load earlier messages!")
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didTapAvatarImageView avatarImageView: UIImageView!, at indexPath: IndexPath!) {
        NSLog("Tapped avatar!")
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didTapMessageBubbleAt indexPath: IndexPath!) {
        NSLog("Tapped message bubble!")
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didTapCellAt indexPath: IndexPath!, touchLocation: CGPoint) {
        NSLog("Tapped cell at %@!", NSStringFromCGPoint(touchLocation))
    }
    // 改变高度cell
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellTopLabelAt indexPath: IndexPath!) -> CGFloat {
        
        if (indexPath.item % 3 == 0) {
            return kJSQMessagesCollectionViewCellLabelHeightDefault
        }
        
        return 0.0
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat {
        
        let currentMessage : JSQMessage = self.messages[indexPath.item]
        if  currentMessage.senderId == self.senderId {
            return 0.0
        }
        
        if indexPath.item - 1 > 0 {
            let previousMessage : JSQMessage = self.messages[indexPath.item - 1]
            if previousMessage.senderId == currentMessage.senderId {
                return 0.0
            }
        }
        
        return kJSQMessagesCollectionViewCellLabelHeightDefault;
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellBottomLabelAt indexPath: IndexPath!) -> CGFloat {
        return 0.0
    }
    // 自定义长按下时的菜单按钮
    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any!) -> Bool {
        if action == #selector(ConversationViewController.customAction(_:)) {
            return true
        }
        return super.collectionView(collectionView, canPerformAction:action, forItemAt:indexPath, withSender:sender)
    }
    
    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any!) {
        if action == #selector(ConversationViewController.customAction(_:)) {
            self.customAction(sender as AnyObject)
            return
        }
        
        super.collectionView(collectionView, performAction:action, forItemAt:indexPath, withSender:sender)
    }
    
    func customAction(_ sender : AnyObject) {
        
        // TODO: NSLog("Custom action received! Sender: %@", sender)
//        let  alertView = UIAlertView(  title: "Custom Action",
//                                       message:nil,
//                                       delegate:nil,
//                                       cancelButtonTitle:"OK")
//        
//        alertView.show()
    }
    
    //显示cell上的发送者名字
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString? {
        
        let  message : JSQMessage = self.messages[indexPath.item]
        if  message.senderId == self.senderId  {
            return nil
        }
        
        if  indexPath.item - 1 > 0 {
            let  previousMessage : JSQMessage = self.messages[indexPath.item - 1]
            if   previousMessage.senderId == message.senderId  {
                return nil;
            }
        }
        return NSAttributedString(string: message.senderDisplayName)
    }
    //每三条消息显示时间戳
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForCellTopLabelAt indexPath: IndexPath!) -> NSAttributedString? {
        
        if (indexPath.item % 3 == 0) {
            let  message : JSQMessage = self.messages[indexPath.item]
            return JSQMessagesTimestampFormatter.shared().attributedTimestamp(for: message.date)
        }
        
        return nil
    }
    
    
    
}

extension ConversationViewController: RCIMClientReceiveMessageDelegate{
    func onReceived(_ message: RCMessage!, left nLeft: Int32, object: Any!) {
        
        if message.objectName == "RC:TxtMsg"{
            
            let dispatch_sec = 0.2
            let delayTime = DispatchTime.now() + Double(Int64(dispatch_sec * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delayTime) {
                let receivedmessage = message.content
                let reveived_contenttext = (receivedmessage as! RCTextMessage).content
                let received_time = Date.init(timeIntervalSince1970: Double(message.receivedTime))
                let received_message = JSQMessage(senderId: self.kJSQAvatarIdTa, senderDisplayName: self.kJSQAvatarDisplayNameTa, date: received_time, text:"\(reveived_contenttext)")
                self.showTypingIndicator = !self.showTypingIndicator
                self.scrollToBottom(animated: true)
                JSQSystemSoundPlayer.jsq_playMessageReceivedSound()
                self.messages.append(received_message!)
                self.finishReceivingMessage(animated: true)
                self.reloadMessagesView()
            }
            
           

        }else if message.objectName == "RC:ImgMsg"{
           
            let dispatch_sec = 0.2
            let delayTime = DispatchTime.now() + Double(Int64(dispatch_sec * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delayTime) {
                let receivedmessage = message.content
                let reveived_imageurl = (receivedmessage as! RCImageMessage).imageUrl
                let received_time = Date.init(timeIntervalSince1970: Double(message.receivedTime))
                let imageurl = URL(string: reveived_imageurl!)
                let imagedata = NSData(contentsOf: imageurl!)
                let image = UIImage(data: imagedata! as Data)
                let photoitem = JSQPhotoMediaItem(image: image)
                photoitem?.appliesMediaViewMaskAsOutgoing = false
                let received_message = JSQMessage(senderId: self.kJSQAvatarIdTa, senderDisplayName: self.kJSQAvatarDisplayNameTa, date: received_time, media: photoitem)
                
                self.showTypingIndicator = !self.showTypingIndicator
                self.scrollToBottom(animated: true)
                JSQSystemSoundPlayer.jsq_playMessageReceivedSound()
                self.messages.append(received_message!)
                self.finishReceivingMessage(animated: true)
                self.reloadMessagesView()
            }

        }
            
        
    }
    
}


