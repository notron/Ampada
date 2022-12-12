//
//  LoginViewModel.swift
//  Ampada
//
//  Created by Mahdi on 12/12/22.
//

import Foundation
import Combine
import UIKit

class LoginViewModel {
    
    var subscriptions = Set<AnyCancellable>()
    let emailRepository : EmailRepository
    weak var view: LoginViewController?
    
    init(_ emailRepository: EmailRepository) {
        self.emailRepository = emailRepository
    }
    
    func signIn(userName: String, password: String) {
        
        emailRepository.getToken(with: userName, password: password)
            .sink(receiveCompletion: {value in

            }, receiveValue: { [weak self] (status, error) in
            
                if (error != nil) {
                    print(error!.message)
                    self?.view?.addAlert(error!.message)
                } else {
                    
                    guard let tokenId = self?.emailRepository.token?.id else {
                        return
                    }
                    self?.getAccount(id: tokenId)
                }

        }).store(in: &subscriptions)
    }
    
    func getAccount(id: String) {
        
        emailRepository.getAccount(with: id)
            .sink(receiveCompletion: {value in

            }, receiveValue: { [weak self] (account, error) in
            
                if (error != nil) {
                    self?.view?.addAlert(error!.message)
                } else {
                    
                    guard let account = account else {
                        return
                    }
                    
                    guard let repo = self?.emailRepository else {
                        return
                    }
                    
                    let view = UINavigationController(rootViewController: HomeViewController(.init(repo, account: account)))
                    UIApplication.shared.currentUIWindow()?.rootViewController = view
                    UIApplication.shared.currentUIWindow()?.makeKeyAndVisible()
                }

        }).store(in: &subscriptions)
    }
}
