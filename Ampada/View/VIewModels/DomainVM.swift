//
//  DomainVM.swift
//  Ampada
//
//  Created by Mahdi on 12/12/22.
//

import Foundation

struct DomainVM {
    
    var title: String
    var domain: Domain
    
    init(_ domain: Domain) {
        
        title = domain.domain
        self.domain = domain
    }
}
