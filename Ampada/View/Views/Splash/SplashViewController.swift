//
//  SplashViewController.swift
//  Ampada
//
//  Created by Mahdi on 12/12/22.
//

import UIKit

class SplashViewController: UIViewController {
    
    private let splashViewModel: SplashViewModel
    
    init(_ splashViewModel: SplashViewModel) {
        
        self.splashViewModel = splashViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        splashViewModel.viewDidLoad()

        //UINavigationController(rootViewController: LoginViewController(.init(EmailRepositoryIMP())))
    }
}
