//
//  MessageVM.swift
//  Ampada
//
//  Created by Mahdi on 12/13/22.
//

import Foundation

struct MessageVM {
    
    var user: String
    var subject: String
    var intro: String
    var date: String
    
    init(_ message: Message) {
        
        user    = message.from.name
        subject = message.subject
        intro   = message.intro
        date   = message.createdAt.LoppString
    }
}
