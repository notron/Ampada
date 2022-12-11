//
//  Token.swift
//  Ampada
//
//  Created by Mahdi on 12/11/22.
//

import Foundation

struct Token {
    
    let id    : String
    let token : String
    
    init(_ tokenDTO: TokenDTO) {
        
        id    = tokenDTO.id
        token = tokenDTO.token
    }
    
    init?() {
        
        guard let currentId = UserDefaults.standard.value(forKey: Constants.id) as? String else {
            return nil
        }
        
        guard let currentToken = UserDefaults.standard.value(forKey: Constants.token) as? String else {
            return nil
        }
        
        id = currentId
        token = currentToken
    }
}

extension Token {
    
    func saveToUserDefault() {
        
        UserDefaults.standard.setValue(id, forKey: Constants.id)
        UserDefaults.standard.setValue(token, forKey: Constants.token)
        UserDefaults.standard.synchronize()
    }
}

