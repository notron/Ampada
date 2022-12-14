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
                    
                    guard let repo = self?.emailRepository  else {
                        return
                    }
                    
                    let view = UINavigationController(rootViewController: LoginViewController(.init(repo)))
                    UIApplication.shared.currentUIWindow()?.rootViewController = view
                    UIApplication.shared.currentUIWindow()?.makeKeyAndVisible()
                    
                } else {
                    
                    guard let account = account else {
                        return
                    }
                    
                    guard let repo = self?.emailRepository  else {
                        return
                    }
                    
                    let view = UINavigationController(rootViewController: HomeViewController(.init(repo, account: account)))
                    UIApplication.shared.currentUIWindow()?.rootViewController = view
                    UIApplication.shared.currentUIWindow()?.makeKeyAndVisible()
                }
            
            }).store(in: &subscriptions)
            
        } else {
            
            let view = UINavigationController(rootViewController: LoginViewController(.init(emailRepository)))
            UIApplication.shared.currentUIWindow()?.rootViewController = view
            UIApplication.shared.currentUIWindow()?.makeKeyAndVisible()
        }
    }
}
