//
//  ChatLogViewController.swift
//  ChatClone
//
//  Created by Claire Roughan on 13/05/2019.
//  Copyright © 2019 Claire Roughan. All rights reserved.
//

import UIKit

class ChatLogViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    private let cellId = "ChatCell"
    
    var messagesArray = [Message?]()

    @IBOutlet weak var inputBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var adminTypingBtn: UIBarButtonItem!
    @IBOutlet weak var chatLogTableView: UITableView!
    @IBOutlet weak var sendMessageInputView: UITextField!
    
    lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        let titleColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        //  button.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        return button
    }()
    
  
    // MARK: -  Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        chatLogTableView.backgroundView?.backgroundColor = UIColor.clear
        chatLogTableView.backgroundColor = UIColor.clear
        
        let backgroundImage = UIImage(named: "Background")
        let imageView = UIImageView(image: backgroundImage)
        self.chatLogTableView.backgroundView = imageView
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createMessages()
        
        for msg in messagesArray {
            debugPrint(msg!)
        }
        
        self.sendMessageInputView.delegate = self
        
        chatLogTableView.estimatedRowHeight = 150.0
        chatLogTableView.rowHeight = UITableView.automaticDimension
        self.chatLogTableView.register(ChatMsgTableViewCell.self, forCellReuseIdentifier:cellId)
        chatLogTableView.backgroundView = UIImageView.init(image: UIImage(named: "Background"))
        
        keyboardNotificationsSetup()
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
        
        scrollToBottomMessage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: self.view.window)
    }
    
    private func keyboardNotificationsSetup() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil);
    }
    
    
    
    // MARK: - Keyboard Logic
    @objc func keyboardWillShow(notification: NSNotification) {
        print("\n Will show notification")
        self.scrollToBottomMessage()
        
        adjustHeightforkeyboard(showing:true, notification: notification)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        print("\n Will Hide notification")
        adjustHeightforkeyboard(showing:false, notification: notification)
    }
    
    private func adjustHeightforkeyboard(showing:Bool, notification: NSNotification) {
        
        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        print(keyboardFrame)
        
        guard let animationDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval) else { return }
        
        guard let animationCurve = (notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt) else { return }
        
        let changedHeight = keyboardFrame.height * (showing ? 1 : -1)
        print(changedHeight)
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: UIView.AnimationOptions(rawValue: animationCurve), animations: {
            self.inputBottomConstraint.constant += changedHeight
            self.view.setNeedsLayout()
        }, completion: { (completed) in
            if(showing) {
                self.scrollToBottomMessage()
            }
        })
    }
    
    // MARK: - UI Logic
    
    // Dismiss keyboard if container view is tapped
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // Scroll to bottom of messages
    func scrollToBottomMessage() {
        if self.messagesArray.count == 0 { return }
        let indexPath = IndexPath(row: self.messagesArray.count-1, section: 0)
        self.chatLogTableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: true)
    }
    
    // MARK: - Simulate typing
    
    @IBAction func adminIsTyping(_ sender: Any) {
        
        print("\n Do admin typing amination")
        
        let adminTypingMsg = Message(to:"Fred", from:"Admin", text:"        ", sentOn:generateRandomDate(daysBack: 5)!, isBackend: true)
        messagesArray.append(adminTypingMsg)
        
        self.chatLogTableView.reloadData()
        scrollToBottomMessage()
    }
    
    
    private func createMessages() {
        
        let msg1 = Message(to:"Fred", from:"Admin", text:"Good morning..", sentOn:generateRandomDate(daysBack: 5)!, isBackend:true)
        messagesArray.append(msg1)
        
        let msg2 = Message(to:"Fred", from:"Admin", text:"Hello, how are you? Hope you are having a lucky morning!", sentOn:generateRandomDate(daysBack: 5)!, isBackend:true)
        messagesArray.append(msg2)
        
        let msg3 = Message(to:"Admin", from:"Fred", text:"Hello, yes I'm doing fine today", sentOn:generateRandomDate(daysBack: 5)!, isBackend:false)
        messagesArray.append(msg3)
        
        let msg4 = Message(to:"Fred", from:"Admin", text:"We just wanted to get in touch to inform you of a new, great, unbelievable, supperduper great offer coming your way next week.  would you like to hear more and sign up?", sentOn:generateRandomDate(daysBack: 5)!, isBackend:true)
        messagesArray.append(msg4)
        
        let msg5 = Message(to:"Admin", from:"Fred", text:"What's the offer?", sentOn:generateRandomDate(daysBack: 5)!, isBackend:false)
        messagesArray.append(msg5)
        
        let msg6 = Message(to:"Fred", from:"Admin", text:"We are giving the first 100 people to sign up a £10 free bet and a chance to enter the prize draw to win your own race horse", sentOn:generateRandomDate(daysBack: 5)!, isBackend:true)
        messagesArray.append(msg6)
        
        let msg7 = Message(to:"Admin", from:"Fred", text:"I live on the 10th floor of a flat, so a horse wouldn't be much use to me!", sentOn:generateRandomDate(daysBack: 5)!, isBackend:false)
        messagesArray.append(msg7)
        
        let msg8 = Message(to:"Fred", from:"Admin", text:"Ha, ha. No we will take care of the stable and trainer fees, its all part of the prize", sentOn:generateRandomDate(daysBack: 5)!, isBackend:true)
        messagesArray.append(msg8)
        
        let msg9 = Message(to:"Admin", from:"Fred", text:"Phew!  I wouldn't have liked trying to get a horse in a lift everyday. How do I sign up? ", sentOn:generateRandomDate(daysBack: 5)!, isBackend:false)
        messagesArray.append(msg9)
        
        let msg10 = Message(to:"Fred", from:"Admin", text:"Just credit your account with £50 and your all set", sentOn:generateRandomDate(daysBack: 5)!, isBackend:true)
        messagesArray.append(msg10)
        
    }
    
    
    private func generateRandomDate(daysBack: Int)-> Date?{
        let day = arc4random_uniform(UInt32(daysBack))+1
        let hour = arc4random_uniform(23)
        let minute = arc4random_uniform(59)
        
        let today = Date(timeIntervalSinceNow: 0)
        let gregorian  = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        var offsetComponents = DateComponents()
        offsetComponents.day = Int(day - 1)
        offsetComponents.hour = Int(hour)
        offsetComponents.minute = Int(minute)
        
        let randomDate = gregorian?.date(byAdding: offsetComponents, to: today, options: .init(rawValue: 0) )
        return randomDate
    }

    
}
    
    // MARK: - UITextField Delegate
    
extension ChatLogViewController: UITextFieldDelegate {
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.text = ""
        view.endEditing(true)
        return false
    }
}


extension ChatLogViewController {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ChatMsgTableViewCell = self.chatLogTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatMsgTableViewCell

        cell.backgroundView?.backgroundColor = UIColor.blue
        cell.contentView.backgroundColor = UIColor.clear
        
        let theMessgage = self.messagesArray[indexPath.row]
        cell.messageTextView.text = self.messagesArray[indexPath.row]?.msgText
        cell.nameLabel.text = self.messagesArray[indexPath.row]?.msgFrom
        cell.timeLabel.text =  dateToString(date: self.messagesArray[indexPath.row]!.msgDate)
        
        let size =  CGSize(width: 250, height: 1200)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: (theMessgage?.msgText!)!).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
        
        //incoming admin message
        if theMessgage?.isFromBackend == true {
            cell.messageTextView.frame = CGRect(x: 48 + 10, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
            
            cell.textBubbleView.frame = CGRect(x: 48 - 12, y: -4, width: estimatedFrame.width + 16 + 8 + 16, height: estimatedFrame.height + 20 + 6)
            
            cell.bubbleImageView.image = ChatMsgTableViewCell.adminBubbleImage
            //cell.bubbleImageView.tintColor = UIColor(white: 0.95, alpha: 1)
            cell.bubbleImageView.tintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            
        } else {
            
            //outgoing sending message
            
            cell.messageTextView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 16 - 16 - 8, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
            
            cell.textBubbleView.frame = CGRect(x:view.frame.width - estimatedFrame.width - 16 - 8 - 30, y: 0, width:estimatedFrame.width + 16 + 8 + 10, height:estimatedFrame.height + 20 + 6)
            
            //cell.textBubbleView.backgroundColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
            cell.bubbleImageView.image = ChatMsgTableViewCell.userBubbleImage
            cell.bubbleImageView.tintColor = UIColor(red: 253/255, green: 231/255, blue: 51/255, alpha: 1)
        }
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let messageText = messagesArray[indexPath.row]?.msgText {
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
            
            print("\n")
            print(estimatedFrame.height + 40)
            
            return CGFloat(estimatedFrame.height + 40)
        }
        
        return CGFloat(100)
    }
    
    
    func dateToString(date:(Date))-> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MM/dd/yy h:mm"
        return dateformatter.string(from: date)
    }
    
}
