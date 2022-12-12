//
//  HomeViewController.swift
//  Ampada
//
//  Created by Mahdi on 12/11/22.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    
    private let homeViewModel: HomeViewModel
    private var subscriptions = Set<AnyCancellable>()
    private var messages = [MessageVM]()
    private var homeDataSource : HomeTableViewDataSource!
    private var timer = Timer()
    
    init(_ homeViewModel: HomeViewModel) {
        
        self.homeViewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeDataSource = HomeTableViewDataSource(items: messages, tableView: tableView, delegate: self)
        
        tableView.dataSource = homeDataSource
        tableView.delegate   = homeDataSource
        
        homeViewModel.messageViewModelsBind.sink(receiveValue: {
            [weak self] messages in
            
            self?.messages = messages
            self?.homeDataSource.updateTable(items: messages)

            }).store(in: &subscriptions)
        
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { _ in
            self.homeViewModel.getMessage(page: 1)
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        homeViewModel.getMessage(page: 1)
    }
}

extension HomeViewController: HomeTableViewDataSourceDelegate {
    
    func didSelectRow(index: Int) {
        print("select index: \(index)")
    }
}
