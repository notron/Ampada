//
//  HomeViewController.swift
//  Ampada
//
//  Created by Mahdi on 12/11/22.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //        if emailRepositoryIMP.doWeHaveAToken() == .success {
    //            getMessage()
    //        }
    
//    func login(domain: Domain) {
//        
//        emailRepositoryIMP.signUp(with: "mahdi2", password: "12345", domain: domain)
//            .sink(receiveCompletion: {value in
//            
//        }, receiveValue: { [weak self] value in
//            print("BBBBBBBBBB Bind \(value.address)")
//
//            self?.getToken(account: value)
//            
//        }).store(in: &subscriptions)
//    }
    
    
//    
//    func getToken(account: Account) {
//        
//        emailRepositoryIMP.getToken(with: account.address, password: "12345")
//            .sink(receiveCompletion: {value in
//            
//        }, receiveValue: { [weak self] value in
//            print("CCCCCCCCCC Bind \(value)")
//            
//        }).store(in: &subscriptions)
//    }
//    
//    func getMessage()  {
//        
//        emailRepositoryIMP.getMessages(page: 1)
//            .sink(receiveCompletion: {value in
//            
//            }, receiveValue: { [weak self] value in
//                print("DDDDDDDDDD Bind \(value.map({ $0.intro }))")
//
//                //self?.login(domain: value.first!)
//                
//            }).store(in: &subscriptions)
//    }

}
