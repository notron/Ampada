//
//  LoginViewModel.swift
//  Ampada
//
//  Created by Mahdi on 12/12/22.
//

import Foundation
import Combine

class LoginViewModel {
    
    var subscriptions = Set<AnyCancellable>()
    let emailRepository : EmailRepository
    
    init(_ emailRepository: EmailRepository) {
        self.emailRepository = emailRepository
    }
    
    func signIn(userName: String, password: String) {
        
        emailRepository.getToken(with: userName, password: password)
            .sink(receiveCompletion: {value in

        }, receiveValue: { [weak self] value in
            print("CCCCCCCCCC Bind \(value)")

        }).store(in: &subscriptions)
    }
}
