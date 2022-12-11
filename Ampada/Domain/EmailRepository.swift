//
//  EmailRepository.swift
//  Ampada
//
//  Created by Mahdi on 12/11/22.
//

import Foundation
import Combine

protocol EmailRepository {
    
    /// Get available domains
    /// We have to use this when creating an account, to retrieve the domain.
    ///
    /// - throws: none
    /// - returns: Returns a list of domains by PassthroughSubject (Combine)
    ///
    func getDomains() -> PassthroughSubject<[Domain], Never>
    
    
    /// Creates an Account resource (Registration)
    ///
    /// - parameter username: Account's address
    /// - parameter password: Account's password.
    /// - parameter domain: The domain that user chased.
    /// - throws: none
    /// - returns: Returns a account by PassthroughSubject (Combine)
    ///
    func signUp(with username: String, password: String, domain: Domain) -> PassthroughSubject<Account, Never>
    
    
//    func searchInMovies(with key: String)
//    func addMovieBookmark(id: Int)
//    func removeMovieBookmark(id: Int)
}
