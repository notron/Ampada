//
//  EmailRepository.swift
//  Ampada
//
//  Created by Mahdi on 12/11/22.
//

import Foundation

protocol EmailRepository {
    
    func getDomains()
    func getDomainByID(with id : String)
//    func searchInMovies(with key: String)
//    func addMovieBookmark(id: Int)
//    func removeMovieBookmark(id: Int)
}
