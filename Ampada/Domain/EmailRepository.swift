//
//  EmailRepository.swift
//  Ampada
//
//  Created by Mahdi on 12/11/22.
//

import Foundation
import Combine

protocol EmailRepository {
    
    //  MARK: - DoWeHaveAToken
    /// It check that we have a token in UserDefaults or not
    ///
    /// - throws: none
    /// - returns: Returns a token status
    ///
    func doWeHaveAToken() -> GetTokenStatus
    
    //  MARK: - GetDomains
    /// Get available domains
    /// We have to use this when creating an account, to retrieve the domain.
    ///
    /// - throws: none
    /// - returns: Returns a list of domains by PassthroughSubject (Combine)
    ///
    func getDomains() -> PassthroughSubject<[Domain], Never>
    
    //  MARK: - SignUp
    /// Creates an Account resource (Registration)
    ///
    /// - parameter username: Account's address
    /// - parameter password: Account's password.
    /// - parameter domain: The domain that user chased.
    /// - throws: none
    /// - returns: Returns a account by PassthroughSubject (Combine)
    ///
    func signUp(with username: String, password: String, domain: Domain) -> PassthroughSubject<Account, Never>
    
    //  MARK: - GetToken
    /// Get token with account information
    ///
    /// - parameter username: Account's address
    /// - parameter password: Account's password.
    /// - throws: none
    /// - returns: Returns a token status by PassthroughSubject (Combine)
    ///
    func getToken(with username: String, password: String) -> PassthroughSubject<GetTokenStatus, Never>
    
}
