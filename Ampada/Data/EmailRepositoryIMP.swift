//
//  EmailRepositoryIMP.swift
//  Ampada
//
//  Created by Mahdi on 12/11/22.
//

import Foundation

class EmailRepositoryIMP : EmailRepository {
    
    func getDomains() {
        
        NetworkHandler().sendGetRequest(url: APIConstans.domains, parameters: [:], completion: {
            (response: Any, status: Bool) in
            
            if status {
                //print(response)
                let decoder = JSONDecoder()
                do {
                    let domains = try decoder.decode(DomainsDTO.self, from: response as! Data)
                    print(domains.member.first?.domain)
                } catch {
                    print("getDataList Unexpected error: \(error).")
                }
                
            } else {
                //delegate.checkUserNameFailed()
            }
        })
    }
    
    func getDomainByID(with id: String) {
        
    }
}
