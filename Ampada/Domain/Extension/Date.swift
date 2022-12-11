//
//  Date.swift
//  Ampada
//
//  Created by Mahdi on 12/11/22.
//

import Foundation

extension Date {
    
    init(_ serverTime: String) {
        
        let dateFormatter        = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale     = Locale.current
        dateFormatter.timeZone   = TimeZone(abbreviation: "UTC")
        self = dateFormatter.date(from: serverTime)!
    }
    
    var year : Int {
        
        let calendar   = Calendar.current
        let components = calendar.dateComponents([.year], from: self)
        return components.year!
    }
    
    var month : Int {
        
        let calendar   = Calendar.current
        let components = calendar.dateComponents([.month], from: self)
        return components.month!
    }
    
    var day : Int {
        
        let calendar   = Calendar.current
        let components = calendar.dateComponents([.day], from: self)
        return components.day!
    }
    
    var LoppString : String {
        return "\(self.day).\(self.month).\(self.year)"
    }
}
