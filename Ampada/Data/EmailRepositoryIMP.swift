//
//  EmailRepositoryIMP.swift
//  Ampada
//
//  Created by Mahdi on 12/11/22.
//

import Foundation
import Combine

class EmailRepositoryIMP : EmailRepository {

    private var domainBind = PassthroughSubject<[Domain], Never>()
    private var signUpBind = PassthroughSubject<Account, Never>()
    
    func getDomains() -> PassthroughSubject<[Domain], Never> {
        
        NetworkHandler().sendGetRequest(url: APIConstans.domains, parameters: [:], completion: {
            (response: Any, status: Bool) in
            
            if status {
                do {
                    let domainsDTO = try JSONDecoder().decode(DomainsDTO.self, from: response as! Data)
                    self.domainBind.send(domainsDTO.member.map({ $0.toDomain() }))
                } catch {
                    print("getDataList Unexpected error: \(error).")
                }
            } else {
                //delegate.checkUserNameFailed()
            }
        })
        
        return domainBind
    }
    
    
    func signUp(with username: String, password: String, domain: Domain) -> PassthroughSubject<Account, Never> {
        
        let address = "\(username)@\(domain.domain)"
        
        let parameters = [
            "address"  : address,
            "password" : password
        ]
        
        NetworkHandler().sendPostRequest(url: APIConstans.accounts, parameters: parameters, completion: {
            (response: Any, status: Bool) in
            
            if status {
                //print(response)
                let decoder = JSONDecoder()
                do {
                    let accountDTO = try decoder.decode(AccountDTO.self, from: response as! Data)
                    self.signUpBind.send(accountDTO.toAccount())
                } catch {
                    print("getDataList Unexpected error: \(error).")
                }
                
            } else {
                //delegate.checkUserNameFailed()
            }
        })
        
        return signUpBind
    }
}
