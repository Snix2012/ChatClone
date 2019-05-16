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
        textView.backgroundColor = UIColor.clear
        textView.textColor = UIColor.black
        return textView
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "12:05"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.black
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
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
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
        
        self.backgroundColor = UIColor.clear
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   func setupViews() {

        addSubview(textBubbleView)
        addSubview(messageTextView)

        textBubbleView.addSubview(bubbleImageView)
        bubbleImageView.leadingAnchor.constraint(equalTo:textBubbleView.leadingAnchor).isActive = true
        bubbleImageView.topAnchor.constraint(equalTo: textBubbleView.topAnchor).isActive = true
        bubbleImageView.bottomAnchor.constraint(equalTo:textBubbleView.bottomAnchor).isActive = true
        bubbleImageView.trailingAnchor.constraint(equalTo: textBubbleView.trailingAnchor).isActive = true
    
        addSubview(profileImageView)
        profileImageView.widthAnchor.constraint(equalToConstant: 28).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 28).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: textBubbleView.leftAnchor, constant: -5).isActive = true
        profileImageView.topAnchor.constraint(equalTo: textBubbleView.topAnchor, constant: -10).isActive = true
    }
    
}
