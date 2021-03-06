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
    var chatLogIsEmpty:Bool = true
    var isAdminTyping:Bool = false

    @IBOutlet weak var showSlidyViewController: UIBarButtonItem!
    @IBOutlet weak var inputBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var adminTypingBtn: UIBarButtonItem!
    @IBOutlet weak var chatLogTableView: UITableView!
    @IBOutlet weak var sendMessageInputView: UITextField!
    @IBOutlet weak var emptyChatLogView: UIView!
    
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
        chatLogTableView.backgroundColor = UIColor.clear
        emptyChatLogView.backgroundColor = UIColor.clear
        self.view.addBackgroundImage(imageName: "Background")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Dummy data setup
        createMessages()
        for msg in messagesArray {
            print(msg!)
        }
        
       sortChatsByTime()
        
        
        // Check to see if we have any existing chats
        if(messagesArray.count > 0) {
            emptyChatLogView.isHidden = true
            chatLogTableView.isHidden = false
            chatLogIsEmpty = false
            scrollToBottomMessage()
        }else {
            emptyChatLogView.isHidden = false
            chatLogTableView.isHidden = true
            chatLogIsEmpty = true
        }

        self.sendMessageInputView.delegate = self
        
        chatLogTableView.estimatedRowHeight = 150.0
        chatLogTableView.rowHeight = UITableView.automaticDimension
        self.chatLogTableView.register(ChatMsgTableViewCell.self, forCellReuseIdentifier:cellId)
        
        keyboardNotificationsSetup()
        gesturesSetup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: self.view.window)
    }
    
    private func keyboardNotificationsSetup() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil);
    }
 
    
    private func gesturesSetup() {
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = true
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        rightSwipe.direction = .right
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        leftSwipe.direction = .left
       
        view.addGestureRecognizer(tap)
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
    }
    
    // MARK: - Swipe to show msg send times
    @objc func handleSwipes(sender:UISwipeGestureRecognizer) {
        
        if(sender.direction == .left) {
            print("swipe left")
            
        }
        
        if(sender.direction == .right) {
            print("swipe right")
           
        }
    }

    
    // MARK: - Keyboard Logic
    @objc func keyboardWillShow(notification: NSNotification) {
        print("\n Will show notification")
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
                 self.chatLogTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height - 10, right: 0)
            } else {
                self.chatLogTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -20, right: 0)
            }
            self.scrollToBottomMessage()
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
    
        self.isAdminTyping = true
        
        let adminTypingMsg = Message(to:"Fred", from:"Admin", text:"        ", sentOn:generateRandomDate(daysBack: 5)!, isBackend: true)
        messagesArray.append(adminTypingMsg)
        
        self.chatLogTableView.reloadData()
        scrollToBottomMessage()
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

 // MARK: - UITableview Delegate

extension ChatLogViewController {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        // Find out if last msg is from admin user typing
    
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
            cell.messageTextView.frame = CGRect(x: 58, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
            
            cell.textBubbleView.frame = CGRect(x: 38, y: -4, width: estimatedFrame.width + 40, height: estimatedFrame.height + 26)
            
            cell.bubbleImageView.image = ChatMsgTableViewCell.adminBubbleImage
            cell.bubbleImageView.tintColor = UIColor(white: 0.99, alpha: 1)
            
            cell.profileImageView.image = UIImage(named: "icon-fitzdares")
            cell.profileImageView.isHidden = false
            
        }
        //outgoing sending message
        else {
            cell.messageTextView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 42, y: 4, width: estimatedFrame.width + 14, height: estimatedFrame.height + 20)

            cell.textBubbleView.frame = CGRect(x:view.frame.width - estimatedFrame.width - 54, y: 0, width:estimatedFrame.width + 40, height:estimatedFrame.height + 26)
  
            cell.bubbleImageView.image = ChatMsgTableViewCell.userBubbleImage
            
            // Fitzdares yellow
            cell.bubbleImageView.tintColor = UIColor(red: 253/255, green: 231/255, blue: 51/255, alpha: 1)
            cell.profileImageView.isHidden = true
           
        }
        return cell;
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let messageText = messagesArray[indexPath.row]?.msgText {
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
  
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

extension UIView {
    
    func addBackgroundImage(imageName:String) {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageViewBackground.image = UIImage(named: imageName)
        
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill
        
        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
    }
}
