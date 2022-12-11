//
//  Account.swift
//  Ampada
//
//  Created by Mahdi on 12/11/22.
//

import Foundation

struct Account {
    
    let id          : String
    let address     : String
    let quota       : Int
    let used        : Int
    let isDisabled  : Bool
    let isDeleted   : Bool
    let createdAt   : Date
    let updatedAt   : Date
    let retentionAt : Date
    
    init(_ accountDTO: AccountDTO) {
        
        id          = accountDTO.id
        address     = accountDTO.address
        quota       = accountDTO.quota
        used        = accountDTO.used
        isDisabled  = accountDTO.isDisabled
        isDeleted   = accountDTO.isDeleted
        createdAt   = Date(accountDTO.createdAt)
        updatedAt   = Date(accountDTO.updatedAt)
        retentionAt = Date(accountDTO.retentionAt)
    }
}

