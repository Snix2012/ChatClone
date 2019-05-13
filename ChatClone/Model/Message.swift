//
//  Message.swift
//  ChatClone
//
//  Created by Claire Roughan on 13/05/2019.
//  Copyright © 2019 Claire Roughan. All rights reserved.
//

import Foundation

struct Message {
    
    var msgTo: String
    var msgFrom: String
    var msgText: String?
    var msgDate: Date
    var isFromBackend: Bool?
   
    
    init(to:String, from:String, text:String, sentOn:Date, isBackend:Bool) {
        msgTo = to
        msgFrom = from
        msgText = text
        msgDate = sentOn
        isFromBackend = isBackend
        
    }
    
}
