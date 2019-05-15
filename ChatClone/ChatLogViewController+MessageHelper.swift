//
//  ChatLogViewController+MessageHelper.swift
//  ChatClone
//
//  Created by Claire Roughan on 13/05/2019.
//  Copyright © 2019 Claire Roughan. All rights reserved.
//

import Foundation

extension ChatLogViewController {
    
/*
msgTo: String
msgFrom: String
msgText: String?
msgDate: Date
isFromBackend: Bool?
*/

    func createMessages() {
        
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
    
    
    func generateRandomDate(daysBack: Int)-> Date?{
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

