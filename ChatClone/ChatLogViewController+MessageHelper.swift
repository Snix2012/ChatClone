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

    /* if dates of messages are equal to current date - chatlog table will have a header , else if their in the past it doesn't
       need to sort the messages array by date.  Question, how long back to msg get saved/displayed for?  What's the cut off?
     */
    func createMessages() {

        let msg2DaysAgo = Message(to:"Fred", from:"Admin", text:"Good morning..", sentOn:getDateFromString(dateStr: "2019-03-12 19:39:02"), isBackend:true)
        messagesArray.append(msg2DaysAgo)

        let msg1DaysAgo = Message(to:"Fred", from:"Admin", text:"Good morning..", sentOn:getDateFromString(dateStr: "2019-04-04 09:01:57"), isBackend:true)
        messagesArray.append(msg1DaysAgo)
        
        let msg1 = Message(to:"Fred", from:"Admin", text:"Good morning..", sentOn:generateRandomDate(daysBack: 1)!, isBackend:true)
        messagesArray.append(msg1)
        
        let msg2 = Message(to:"Fred", from:"Admin", text:"Hello, how are you? Hope you are having a lucky morning!", sentOn:generateRandomDate(daysBack: 3)!, isBackend:true)
        messagesArray.append(msg2)
        
        let msg3 = Message(to:"Admin", from:"Fred", text:"Hello, yes I'm doing fine today", sentOn:generateRandomDate(daysBack: 5)!, isBackend:false)
        messagesArray.append(msg3)
        
        let msg4 = Message(to:"Fred", from:"Admin", text:"We just wanted to get in touch to inform you of a new, great, unbelievable, supperduper great offer coming your way next week.  would you like to hear more and sign up?", sentOn:generateRandomDate(daysBack: 0)!, isBackend:true)
        messagesArray.append(msg4)
        
        let msg5 = Message(to:"Admin", from:"Fred", text:"What's the offer?", sentOn:generateRandomDate(daysBack:0)!, isBackend:false)
        messagesArray.append(msg5)
        
        let msg6 = Message(to:"Fred", from:"Admin", text:"We are giving the first 100 people to sign up a £10 free bet and a chance to enter the prize draw to win your own race horse", sentOn:generateRandomDate(daysBack: 0)!, isBackend:true)
        messagesArray.append(msg6)
        
        let msg7 = Message(to:"Admin", from:"Fred", text:"I live on the 10th floor of a flat, so a horse wouldn't be much use to me!", sentOn:generateRandomDate(daysBack: 0)!, isBackend:false)
        messagesArray.append(msg7)
        
        let msg8 = Message(to:"Fred", from:"Admin", text:"Ha, ha. No we will take care of the stable and trainer fees, its all part of the prize", sentOn:generateRandomDate(daysBack: 0)!, isBackend:true)
        messagesArray.append(msg8)
        
        let msg9 = Message(to:"Admin", from:"Fred", text:"Phew!  I wouldn't have liked trying to get a horse in a lift everyday. How do I sign up? ", sentOn:generateRandomDate(daysBack: 14)!, isBackend:false)
        messagesArray.append(msg9)
        
        let msg10 = Message(to:"Fred", from:"Admin", text:"Just credit your account with £50 and your all set", sentOn:generateRandomDate(daysBack: 2)!, isBackend:true)
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
        
        print(randomDate!)
        return randomDate
    }
    
    
    func getDateFromString(dateStr: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateStr)
        print(date!)
        return date!
    }
    
    
    // MARK: - Sort chatMsgs by timeStamp
    
    func sortChatsByTime() {
        
        /* When we have the msgs need to sort them by date then group them as this will determine date table header sections */
        print("\n\n")
        let newArr = messagesArray.sorted{($0!.msgDate).compare($1!.msgDate)  == .orderedAscending}
        for msg in newArr {
            print(msg!)
        }
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dictionary = Dictionary(grouping: newArr) { dateWithOutTime(datDate: $0?.msgDate) }
        print(dictionary.keys)
        
        let sortedDict = dictionary.sorted { $0.0 < $1.0 }
        for (key, value) in sortedDict {
            print("\nkey is - \(key)\n and value is - \(value)\n")
        }

    }
    
    
    func dateWithOutTime(datDate: Date?) -> Date {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: datDate! as Date)
        
        print(calendar.date(from: components)!)
        return calendar.date(from: components)!
    }
    
}


    


