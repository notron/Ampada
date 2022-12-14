//
//  EmailRepository.swift
//  Ampada
//
//  Created by Mahdi on 12/11/22.
//

import Foundation
import Combine

protocol EmailRepository {
    
    var token: Token? { get set }
    
    //  MARK: - DoWeHaveAToken
    /// It check that we have a token in UserDefaults or not
    ///
    /// - throws: None
    /// - returns: Returns a token status
    ///
    func doWeHaveAToken() -> GetTokenStatus
    
    //  MARK: - GetDomains
    /// Get available domains
    /// We have to use this when creating an account, to retrieve the domain.
    ///
    /// - throws: None
    /// - returns: Returns a list of domains by PassthroughSubject (Combine)
    ///
    func getDomains() -> PassthroughSubject<[Domain], Never>
    
    //  MARK: - SignUp
    /// Creates an Account resource (Registration)
    ///
    /// - parameter username: Account's address
    /// - parameter password: Account's password.
    /// - parameter domain: The domain that user chased.
    /// - throws: None
    /// - returns: Returns a account by PassthroughSubject (Combine)
    ///
    func signUp(with username: String, password: String, domain: Domain) -> PassthroughSubject<Account, Never>
    
    //  MARK: - GetToken
    /// Get token with account information
    ///
    /// - parameter username: Account's address
    /// - parameter password: Account's password.
    /// - throws: None
    /// - returns: Returns a token status by PassthroughSubject (Combine)
    ///
    func getToken(with username: String, password: String) -> PassthroughSubject<(GetTokenStatus?, Error?), Never>
    
    //  MARK: - GetAccount
    /// Get an Account resource by its id
    /// Obviously, the Bearer token needs to be the one of the account you are trying to retrieve
    ///
    /// - parameter id: Account's id
    /// - throws: None
    /// - returns: Returns a account status by PassthroughSubject (Combine)
    ///
    func getAccount(with id: String) -> PassthroughSubject<(Account?, Error?), Never>
    
    //  MARK: - logOut
    /// LogOut Account from device
    ///
    /// - throws: None
    /// - returns: None
    ///
    func logOut()
    
    //  MARK: - GetMessages
    /// Gets all the message resources of a given page.
    ///
    /// - parameter username: Account's address
    /// - parameter password: Account's password.
    /// - throws: None
    /// - returns: Returns Messages by PassthroughSubject (Combine)
    ///
    func getMessages(page: Int) -> PassthroughSubject<[Message], Never>
    
}
