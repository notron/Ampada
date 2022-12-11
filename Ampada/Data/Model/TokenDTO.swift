//
//  TokenDTO.swift
//  Ampada
//
//  Created by Mahdi on 12/11/22.
//

import Foundation

struct TokenDTO: Decodable {
    
    let id    : String
    let token : String
}

extension TokenDTO {
    
    func toToken() -> Token {
        return Token(self)
    }
}
