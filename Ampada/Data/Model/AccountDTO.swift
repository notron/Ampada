//
//  AccountDTO.swift
//  Ampada
//
//  Created by Mahdi on 12/11/22.
//

import Foundation

struct AccountDTO: Decodable {
    
    let id          : String
    let address     : String
    let quota       : Int
    let used        : Int
    let isDisabled  : Bool
    let isDeleted   : Bool
    let createdAt   : String
    let updatedAt   : String
    let retentionAt : String
    
}

extension AccountDTO {
    
    func toAccount() -> Account {
        return Account(self)
    }
}
