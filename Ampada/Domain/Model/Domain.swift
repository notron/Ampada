//
//  Domain.swift
//  Ampada
//
//  Created by Mahdi on 12/11/22.
//

import Foundation

class Domain {
    
    let id        : String
    let domain    : String
    let isActive  : Bool
    let createdAt : Date
    let updatedAt : Date
    
    init(_ domainDTO: DomainDTO) {
        
        id = domainDTO.id
        domain = domainDTO.domain
        isActive = domainDTO.isActive
        createdAt = Date(domainDTO.createdAt)
        updatedAt = Date(domainDTO.updatedAt)
    }
}
