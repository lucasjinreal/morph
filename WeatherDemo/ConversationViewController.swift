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
    
    let kJSQDemoAvatarDisplayNameCook = "Tim Cook"
    let kJSQDemoAvatarDisplayNameJobs = "Jobs"
    
    
    let kJSQDemoAvatarIdCook          = "468-768355-23123"
    let kJSQDemoAvatarIdJobs          = "707-8956784-57"
    
    var messages : [JSQMessage] = []
    var avatars  : Dictionary< String, JSQMessagesAvatarImage> = [:]
    var users    : Dictionary< String, String> = [:]
    
    var outgoingBubbleImageData : JSQMessagesBubbleImage!
    var incomingBubbleImageData : JSQMessagesBubbleImage!
    
    // This value replace kJSQMessagesCollectionViewAvatarSizeDefault which lead to some trouble with swift type system
    let messagesCollectionViewAvatarSizeDefault = UInt(kJSQMessagesCollectionViewAvatarSizeDefault)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
        self.addDemoMessages()
        
        self.create_avatars()
        self.create_bubble_image_objects()
        
        
        //self.showLoadEarlierMessagesHeader     = true
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.jsq_defaultTypingIndicatorImage(), style: UIBarButtonItemStyle.Bordered, target: self, action: #selector(ConversationViewController.receiveMessagePressed(_:)))
        
    }
    
    func receiveMessagePressed(sender: UIButton){
        self.showTypingIndicator = !self.showTypingIndicator
        self.scrollToBottomAnimated(true)
        let dispatch_sec = 1.5
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(dispatch_sec * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            JSQSystemSoundPlayer.jsq_playMessageReceivedSound()
            let message_test = JSQMessage(senderId: self.kJSQDemoAvatarIdCook, displayName: self.kJSQDemoAvatarDisplayNameCook, text: "这是库克在说话")
            self.messages.append(message_test)
            self.finishReceivingMessageAnimated(true)
        }
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.collectionView!.collectionViewLayout.springinessEnabled = true
    }
    
    
    func reloadMessagesView() {
        self.collectionView?.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func create_avatars() {
        let jsqImage : JSQMessagesAvatarImage    = JSQMessagesAvatarImageFactory.avatarImageWithUserInitials( "JSQ", backgroundColor: UIColor(white: 0.85, alpha:1.0), textColor: UIColor(white: 0.60, alpha:1.0), font: UIFont.systemFontOfSize(14.0), diameter: messagesCollectionViewAvatarSizeDefault
        )
        
        let cookImage : JSQMessagesAvatarImage   = JSQMessagesAvatarImageFactory.avatarImageWithImage( UIImage(named: "demo_avatar_cook") , diameter:messagesCollectionViewAvatarSizeDefault )
        let jobsImage : JSQMessagesAvatarImage   = JSQMessagesAvatarImageFactory.avatarImageWithImage( UIImage(named: "demo_avatar_jobs") , diameter:messagesCollectionViewAvatarSizeDefault )
        self.avatars = [kJSQDemoAvatarIdCook : cookImage,
                        kJSQDemoAvatarIdJobs : jobsImage]
        self.users   = [kJSQDemoAvatarIdJobs : kJSQDemoAvatarDisplayNameJobs,
                        kJSQDemoAvatarIdCook : kJSQDemoAvatarDisplayNameCook]
        
    }
    
    
    func create_bubble_image_objects() {
        
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        
        self.outgoingBubbleImageData = bubbleFactory.outgoingMessagesBubbleImageWithColor( UIColor.jsq_messageBubbleBlueColor() )
        self.incomingBubbleImageData = bubbleFactory.incomingMessagesBubbleImageWithColor( UIColor.jsq_messageBubbleGreenColor()     )
        
    }
    
    
    
    
    
}
extension ConversationViewController {
    func addDemoMessages() {
        
        let message1 = JSQMessage(senderId: kJSQDemoAvatarIdJobs, displayName: kJSQDemoAvatarDisplayNameJobs, text: "这是乔布斯在说话")
        let message2 = JSQMessage(senderId: kJSQDemoAvatarIdCook, displayName: kJSQDemoAvatarDisplayNameCook, text: "这是库克在说话")
        self.messages.append(message1)
        self.messages.append(message2)
        self.reloadMessagesView()
    }
    
    func setup() {
        self.title = "Mirror"
        self.senderId = kJSQDemoAvatarIdJobs
        self.senderDisplayName = kJSQDemoAvatarDisplayNameJobs
        self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize(width: 30, height: 30)
        self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize(width: 30, height: 30)
    }
}

extension ConversationViewController {
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        let data = self.messages[indexPath.row]
        return data
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, didDeleteMessageAtIndexPath indexPath: NSIndexPath!) {
        self.messages.removeAtIndex(indexPath.row)
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message: JSQMessage! = self.messages[indexPath.item]
        if message.senderId == self.senderId{
            return self.outgoingBubbleImageData
        }else{
            return self.incomingBubbleImageData
        }
    }
    
    override  func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource? {
        
        let message : JSQMessage = self.messages[indexPath.item]
        
        return self.avatars[message.senderId]
    }
    
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        let message = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
        self.messages.append(message)
        self.finishSendingMessageAnimated(true)
    }
    
    override func didPressAccessoryButton(sender: UIButton!) {
        
        let alertController = UIAlertController(title: "Choose to send", message: nil, preferredStyle: .ActionSheet)
        let concelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let archiveAction1 = UIAlertAction(title: "Send Photo", style: .Default, handler: {actiion in
        })
        let archiveAction2 = UIAlertAction(title: "Send location", style: .Default, handler: {action in
        })
        let archiveAction3 = UIAlertAction(title: "Send File", style: .Default, handler: {action in
        })
        alertController.addAction(archiveAction1)
        alertController.addAction(archiveAction2)
        alertController.addAction(archiveAction3)
        alertController.addAction(concelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    //添加时间标签
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForCellBottomLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
        let message: JSQMessage = self.messages[indexPath.item]
        
        return JSQMessagesTimestampFormatter.sharedFormatter().attributedTimestampForDate(message.date)
    }
    //不同地方的点击实现方法
    override func collectionView(collectionView: JSQMessagesCollectionView!, header headerView: JSQMessagesLoadEarlierHeaderView!, didTapLoadEarlierMessagesButton sender: UIButton!) {
        NSLog("Load earlier messages!")
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, didTapAvatarImageView avatarImageView: UIImageView!, atIndexPath indexPath: NSIndexPath!) {
        NSLog("Tapped avatar!")
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, didTapMessageBubbleAtIndexPath indexPath: NSIndexPath!) {
        NSLog("Tapped message bubble!")
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, didTapCellAtIndexPath indexPath: NSIndexPath!, touchLocation: CGPoint) {
        NSLog("Tapped cell at %@!", NSStringFromCGPoint(touchLocation))
    }
    // 改变高度cell
    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        
        if (indexPath.item % 3 == 0) {
            return kJSQMessagesCollectionViewCellLabelHeightDefault
        }
        
        return 0.0
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        
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
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellBottomLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 0.0
    }
    // 自定义长按下时的菜单按钮
    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject!) -> Bool {
        if action == #selector(ConversationViewController.customAction(_:)) {
            return true
        }
        return super.collectionView(collectionView, canPerformAction:action, forItemAtIndexPath:indexPath, withSender:sender)
    }
    
    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject!) {
        if action == #selector(ConversationViewController.customAction(_:)) {
            self.customAction(sender)
            return
        }
        
        super.collectionView(collectionView, performAction:action, forItemAtIndexPath:indexPath, withSender:sender)
    }
    
    func customAction(sender : AnyObject) {
        
        // TODO: NSLog("Custom action received! Sender: %@", sender)
        let  alertView = UIAlertView(  title: "Custom Action",
                                       message:nil,
                                       delegate:nil,
                                       cancelButtonTitle:"OK")
        
        alertView.show()
    }
    
    //显示cell上的发送者名字
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString? {
        
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
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForCellTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString? {
        
        if (indexPath.item % 3 == 0) {
            let  message : JSQMessage = self.messages[indexPath.item]
            return JSQMessagesTimestampFormatter.sharedFormatter().attributedTimestampForDate(message.date)
        }
        
        return nil
    }
    
    
}


