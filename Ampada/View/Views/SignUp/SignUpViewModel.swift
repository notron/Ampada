//
//  SignUpViewModel.swift
//  Ampada
//
//  Created by Mahdi on 12/12/22.
//

import Foundation
import Combine
import UIKit

class SignUpViewModel {
    
    private var subscriptions = Set<AnyCancellable>()
    let emailRepository : EmailRepository
    weak var view: SignUpViewController?
    var account: Account?
    
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
            
            self?.account = value
            self?.getToken(userName: value.address, password: password)

        }).store(in: &subscriptions)
    }
    
    private func getToken(userName: String, password: String) {
        
        emailRepository.getToken(with: userName, password: password)
            .sink(receiveCompletion: {value in

            }, receiveValue: { [weak self] (status, error) in
            
                if (error != nil) {
                    print(error!.message)
                    self?.view?.addAlert(error!.message)
                } else {
                    
                    guard let repo = self?.emailRepository else {
                        return
                    }
                    
                    guard let account = self?.account else {
                        return
                    }
                    
                    let view = UINavigationController(rootViewController: HomeViewController(.init(repo, account: account)))
                    UIApplication.shared.currentUIWindow()?.rootViewController = view
                    UIApplication.shared.currentUIWindow()?.makeKeyAndVisible()
                }

        }).store(in: &subscriptions)
    }
}
