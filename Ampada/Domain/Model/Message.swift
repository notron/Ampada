//
//  Message.swift
//  Ampada
//
//  Created by Mahdi on 12/11/22.
//

import Foundation

struct Message {
    
    let id             : String
    let from           : Person
    let to             : [Person]
    let subject        : String
    let intro          : String
    let seen           : Bool
    let isDeleted      : Bool
    let hasAttachments : Bool
    let downloadUrl    : String
    let createdAt      : Date
    let updatedAt      : Date
    
    
    init(_ messageDTO: MessageDTO) {
        
        id             = messageDTO.id
        from           = messageDTO.from.toPerson()
        to             = messageDTO.to.map({ $0.toPerson() })
        subject        = messageDTO.subject
        intro          = messageDTO.intro
        seen           = messageDTO.seen
        isDeleted      = messageDTO.isDeleted
        hasAttachments = messageDTO.hasAttachments
        downloadUrl    = messageDTO.downloadUrl
        createdAt      = Date(messageDTO.createdAt)
        updatedAt      = Date(messageDTO.updatedAt)
    }
}

extension Message {
    
    func toMessageVM() -> MessageVM {
        return MessageVM(self)
    }
}
