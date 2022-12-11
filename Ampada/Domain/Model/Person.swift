//
//  Person.swift
//  Ampada
//
//  Created by Mahdi on 12/11/22.
//

import Foundation

struct Person {
    
    let address : String
    let name    : String

    init(_ personDTO: PersonDTO) {
        
        address = personDTO.address
        name    = personDTO.name
    }
}
