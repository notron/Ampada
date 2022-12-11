//
//  EmailRepositoryIMP.swift
//  Ampada
//
//  Created by Mahdi on 12/11/22.
//

import Foundation
import Combine

class EmailRepositoryIMP : EmailRepository {
    
    private let networkHandler = NetworkHandler()
    private var domainBind = PassthroughSubject<[Domain], Never>()
    private var signUpBind = PassthroughSubject<Account, Never>()
    private var tokenBind = PassthroughSubject<GetTokenStatus, Never>()
    private var messagesBind = PassthroughSubject<[Message], Never>()
    
    
    //  MARK: - DoWeHaveAToken
    /// It check that we have a token in UserDefaults or not
    ///
    /// - throws: none
    /// - returns: Returns a token status
    ///
    func doWeHaveAToken() -> GetTokenStatus {
        
        guard let token = Token() else {
            return .failed
        }
        
        networkHandler.token = token.token
        print("Token = \(networkHandler.token)")
        
        return .success
    }
    
    
    //  MARK: - GetDomains
    /// Get available domains
    /// We have to use this when creating an account, to retrieve the domain.
    ///
    /// - throws: none
    /// - returns: Returns a list of domains by PassthroughSubject (Combine)
    ///
    func getDomains() -> PassthroughSubject<[Domain], Never> {
        
        networkHandler.sendGetRequest(url: APIConstans.domains, parameters: [:], completion: {
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
    
    
    //  MARK: - SignUp
    /// Creates an Account resource (Registration)
    ///
    /// - parameter username: Account's address
    /// - parameter password: Account's password.
    /// - parameter domain: The domain that user chased.
    /// - throws: none
    /// - returns: Returns a account by PassthroughSubject (Combine)
    ///
    func signUp(with username: String, password: String, domain: Domain) -> PassthroughSubject<Account, Never> {
        
        let address = "\(username)@\(domain.domain)"
        
        let parameters = [
            "address"  : address,
            "password" : password
        ]
        
        networkHandler.sendPostRequest(url: APIConstans.accounts, parameters: parameters, completion: {
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
    
    
    //  MARK: - GetToken
    /// Get token with account information
    ///
    /// - parameter username: Account's address
    /// - parameter password: Account's password.
    /// - throws: none
    /// - returns: Returns a token status by PassthroughSubject (Combine)
    ///
    func getToken(with username: String, password: String) -> PassthroughSubject<GetTokenStatus, Never> {
        
        let parameters = [
            "address"  : username,
            "password" : password
        ]
        
        networkHandler.sendPostRequest(url: APIConstans.token, parameters: parameters, completion: {
            (response: Any, status: Bool) in
            
            if status {
                //print(response)
                let decoder = JSONDecoder()
                do {
                    let tokenDTO = try decoder.decode(TokenDTO.self, from: response as! Data)
                    let token = tokenDTO.toToken()
                    token.saveToUserDefault()
                    self.tokenBind.send(.success)
                } catch {
                    self.tokenBind.send(.failed)
                    print("getDataList Unexpected error: \(error).")
                }
                
            } else {
                //delegate.checkUserNameFailed()
            }
        })
        
        return tokenBind
    }
    
    
    //  MARK: - GetMessages
    /// Get messages from the account with the token
    ///
    /// - parameter username: Account's address
    /// - parameter password: Account's password.
    /// - throws: None
    /// - returns: Returns Messages by PassthroughSubject (Combine)
    ///
    func getMessages(page: Int) -> PassthroughSubject<[Message], Never> {
        
        let parameters = [ "page" : page ]
        
        networkHandler.sendGetRequest(url: APIConstans.messages, parameters: parameters, completion: {
            (response: Any, status: Bool) in
            
            if status {
                do {
                    let domainsDTO = try JSONDecoder().decode(MessagesDTO.self, from: response as! Data)
                    self.messagesBind.send(domainsDTO.member.map({ $0.toMessage() }))
                } catch {
                    print("getDataList Unexpected error: \(error).")
                }
            } else {
                //delegate.checkUserNameFailed()
            }
        })
        
        return messagesBind
    }
}
