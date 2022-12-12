//
//  SignUpViewModel.swift
//  Ampada
//
//  Created by Mahdi on 12/12/22.
//

import Foundation
import Combine

class SignUpViewModel {
    
    private var subscriptions = Set<AnyCancellable>()
    let emailRepository : EmailRepository
    
    private var domainViewModelsBind = PassthroughSubject<[DomainVM], Never>()
    
    init(_ emailRepository: EmailRepository) {
        self.emailRepository = emailRepository
    }
    
    func getDomains() -> PassthroughSubject<[DomainVM], Never> {
    
        emailRepository.getDomains()
        .sink(receiveCompletion: {value in
            
        }, receiveValue: { [weak self] value in
            
            self?.domainViewModelsBind.send(value.map({ DomainVM($0) }))
            
        }).store(in: &subscriptions)
        
        return domainViewModelsBind
    }
    
    
    func signUp(userName: String, password: String, domainVM: DomainVM) {
        
        emailRepository.signUp(with: userName, password: password, domain: domainVM.domain)
            .sink(receiveCompletion: {value in

        }, receiveValue: { [weak self] value in
            
            self?.getToken(userName: value.address, password: password)

        }).store(in: &subscriptions)
    }
    
    private func getToken(userName: String, password: String) {
        
        emailRepository.getToken(with: userName, password: password)
        .sink(receiveCompletion: {value in
        
        }, receiveValue: { [weak self] value in
            print("CCCCCCCCCC Bind \(value)")
        
        }).store(in: &subscriptions)
    }
}
