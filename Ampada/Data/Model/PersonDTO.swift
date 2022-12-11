//
//  PersonDTO.swift
//  Ampada
//
//  Created by Mahdi on 12/11/22.
//

import Foundation

struct PersonDTO: Decodable {
    
    let address : String
    let name    : String
    
}

extension PersonDTO {
    
    func toPerson() -> Person {
        return Person(self)
    }
}
