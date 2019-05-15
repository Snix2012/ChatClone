//
//  ChatMsgTableViewCell.swift
//  ChatClone
//
//  Created by Claire Roughan on 13/05/2019.
//  Copyright © 2019 Claire Roughan. All rights reserved.
//

import UIKit

class ChatMsgTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sender's name"
        label.font = UIFont.systemFont(ofSize: 16)
        label.backgroundColor = UIColor.blue
        return label
    }()
    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.text = "Sample message"
        textView.backgroundColor = UIColor.clear
        textView.textColor = UIColor.black
        return textView
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "12:05 pm"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
        label.backgroundColor = UIColor.yellow
        return label
    }()
    
    var message: Message? {
        didSet {
            nameLabel.text = message?.msgFrom
            messageTextView.text = message?.msgText
            
            if let date = message?.msgDate {
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm a"
                
                let elapsedTimeInSeconds = NSDate().timeIntervalSince(date as Date)
                
                let secondInDays: TimeInterval = 60 * 60 * 24
                
                if elapsedTimeInSeconds > 7 * secondInDays {
                    dateFormatter.dateFormat = "MM/dd/yy"
                } else if elapsedTimeInSeconds > secondInDays {
                    dateFormatter.dateFormat = "EEE"
                }
                timeLabel.text = dateFormatter.string(from: date as Date)
            }
            
        }
    }
    
    
    let textBubbleView: UIView = {
        let view = UIView()
       // view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    
    static let adminBubbleImage = UIImage(named: "bubble_left")!.resizableImage(withCapInsets: UIEdgeInsets.init(top: 22, left: 26, bottom: 22, right: 26)).withRenderingMode(.alwaysTemplate)
    static let userBubbleImage = UIImage(named: "bubble_right")!.resizableImage(withCapInsets: UIEdgeInsets.init(top: 22, left: 26, bottom: 22, right: 26)).withRenderingMode(.alwaysTemplate)
    
    let bubbleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ChatMsgTableViewCell.adminBubbleImage
        imageView.tintColor = UIColor(white: 0.90, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   func setupViews() {

        addSubview(textBubbleView)
        addSubview(messageTextView)

//        textBubbleView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        textBubbleView.layer.borderWidth = 2
    
        textBubbleView.addSubview(bubbleImageView)
        bubbleImageView.leadingAnchor.constraint(equalTo:textBubbleView.leadingAnchor).isActive = true
        bubbleImageView.topAnchor.constraint(equalTo: textBubbleView.topAnchor).isActive = true
        bubbleImageView.bottomAnchor.constraint(equalTo:textBubbleView.bottomAnchor).isActive = true
        bubbleImageView.trailingAnchor.constraint(equalTo: textBubbleView.trailingAnchor).isActive = true
    }
    
    
    
    private func setupContainerView() {
        let containerView = UIView()
        addSubview(containerView)
        
        
        
    }
    
//    func setupViews() {
//        print("doing cell set up")
//
//        // Get the superview's layout
//        let margins = self.layoutMarginsGuide
//
//        let containerView = UIView()
//
//        containerView.translatesAutoresizingMaskIntoConstraints = false
//        containerView.leadingAnchor.constraint(equalTo:margins.leadingAnchor, constant: 10).isActive = true
//        containerView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
//        containerView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
//    // containerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
//       // containerView.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
//
//        containerView.addSubview(nameLabel)
//        containerView.addSubview(messageTextView)
//        containerView.addSubview(timeLabel)
//
//
//        nameLabel.translatesAutoresizingMaskIntoConstraints = false
//        messageTextView.translatesAutoresizingMaskIntoConstraints = false
//        timeLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
//        nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
//        nameLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        nameLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
//
//        messageTextView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
//        messageTextView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
//      //  messageTextView.widthAnchor.constraint(equalToConstant: 300).isActive = true
//      //  messageTextView.heightAnchor.constraint(equalToConstant: 30).isActive = true
//
//        timeLabel.topAnchor.constraint(equalTo: messageTextView.bottomAnchor, constant: 0).isActive = true
//        timeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
//        timeLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
//        timeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
//
//        addSubview(textBubbleView)
//        textBubbleView.addSubview(containerView)
//
//        textBubbleView.translatesAutoresizingMaskIntoConstraints = false
//        textBubbleView.leadingAnchor.constraint(equalTo:margins.leadingAnchor).isActive = true
//        textBubbleView.trailingAnchor.constraint(equalTo:margins.trailingAnchor).isActive = true
//        textBubbleView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
//        textBubbleView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
//
//        textBubbleView.addSubview(bubbleImageView)
//        bubbleImageView.translatesAutoresizingMaskIntoConstraints = false
//        bubbleImageView.heightAnchor.constraint(equalToConstant: 45).isActive = true
//        bubbleImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
//
//    }

}
