//
//  SplashViewModel.swift
//  Ampada
//
//  Created by Mahdi on 12/12/22.
//

import Foundation
import Combine
import UIKit

class SplashViewModel {
    
    private var subscriptions = Set<AnyCancellable>()
    let emailRepository : EmailRepository
    
    init(_ emailRepository: EmailRepository) {
        self.emailRepository = emailRepository
        
    }
    
    func viewDidLoad() {

        if emailRepository.doWeHaveAToken() == .success {
            
            let tokenId = emailRepository.token!.id
            
            emailRepository.getAccount(with: tokenId)
            .sink(receiveCompletion: { value in
            
            }, receiveValue: { [weak self] (account, error) in
                
                if (error != nil) {
                    
                    self?.emailRepository.logOut()
                    
                    if let repo = self?.emailRepository {
                        let view = LoginViewController(.init(repo))
                        UIApplication.shared.windows.first?.rootViewController = view
                        UIApplication.shared.windows.first?.makeKeyAndVisible()
                    }
                    
                } else {
                    
                    let view = HomeViewController()
                    UIApplication.shared.windows.first?.rootViewController = view
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                }
            
            }).store(in: &subscriptions)
            
        } else {
            
            let view = LoginViewController(.init(emailRepository))
            UIApplication.shared.windows.first?.rootViewController = view
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
}
