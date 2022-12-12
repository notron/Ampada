//
//  ErrorDTO.swift
//  Ampada
//
//  Created by Mahdi on 12/12/22.
//

import Foundation

struct ErrorDTO: Decodable {
    
    let code    : Int
    let message : String
}

extension ErrorDTO {
    
    func toError() -> Error {
        return Error(self)
    }
}
