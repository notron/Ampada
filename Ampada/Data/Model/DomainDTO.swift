//
//  DomainDTO.swift
//  Ampada
//
//  Created by Mahdi on 12/11/22.
//

import Foundation

struct DomainDTO: Decodable {
    
    let id        : String
    let domain    : String
    let isActive  : Bool
    let createdAt : String
    let updatedAt : String
}

extension DomainDTO {
    
    func toDomain() -> Domain {
        return Domain(self)
    }
}
