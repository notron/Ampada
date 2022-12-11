//
//  MessageDTO.swift
//  Ampada
//
//  Created by Mahdi on 12/11/22.
//

import Foundation

struct MessageDTO: Decodable {
    
    let id             : String
    let from           : PersonDTO
    let to             : [PersonDTO]
    let subject        : String
    let intro          : String
    let seen           : Bool
    let isDeleted      : Bool
    let hasAttachments : Bool
    let downloadUrl    : String
    let createdAt      : String
    let updatedAt      : String
}

extension MessageDTO {
    
    func toMessage() -> Message {
        return Message(self)
    }
}

