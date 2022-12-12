//
//  HomeViewModel.swift
//  Ampada
//
//  Created by Mahdi on 12/12/22.
//

import Foundation
import Combine

class HomeViewModel {
    
    private var subscriptions = Set<AnyCancellable>()
    let emailRepository : EmailRepository
    let account: Account
    
    var messageViewModelsBind = PassthroughSubject<[MessageVM], Never>()
    
    init(_ emailRepository: EmailRepository, account: Account) {
        self.emailRepository = emailRepository
        self.account = account
    }
    
    func getMessage(page: Int) {
        
        emailRepository.getMessages(page: page)
            .sink(receiveCompletion: {value in

            }, receiveValue: { [weak self] value in
                print("DDDDDDDDDD Bind \(value.map({ $0.intro }))")

                self?.messageViewModelsBind.send(value.map({ $0.toMessageVM() }))
                //self?.login(domain: value.first!)

            }).store(in: &subscriptions)
    }
}
