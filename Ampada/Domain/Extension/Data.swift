//
//  Data.swift
//  Ampada
//
//  Created by Mahdi on 12/11/22.
//

import Foundation

extension Data {
    
    func convertToDictionary() -> [String:AnyObject]? {
        
        do {
            let json = try JSONSerialization.jsonObject(with: self, options: .mutableContainers) as? [String:AnyObject]
            return json
        } catch {
            print("Something went wrong")
        }
        return nil
    }
}
