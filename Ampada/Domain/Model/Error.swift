//
//  Error.swift
//  Ampada
//
//  Created by Mahdi on 12/12/22.
//

import Foundation

struct Error {
    
    let code    : Int
    let message : String
    
    init(_ message: String) {
        
        code = 0
        self.message = message
    }
    
    init(_ errorDTO: ErrorDTO) {
        
        code    = errorDTO.code
        message = errorDTO.message
    }
}
