//
//  MessagesDTO.swift
//  Ampada
//
//  Created by Mahdi on 12/11/22.
//

import Foundation

struct MessagesDTO: Decodable {
    
    let context    : String
    let id         : String
    let type       : String
    let member     : [MessageDTO]
    let totalItems : Int
    
    enum CodingKeys: String, CodingKey {
        
        case context    = "@context"
        case id         = "@id"
        case type       = "@type"
        case member     = "hydra:member"
        case totalItems = "hydra:totalItems"
    }
}
