//
//  HomeTableViewDataSource.swift
//  Ampada
//
//  Created by Mahdi on 12/13/22.
//

import Foundation
import UIKit

protocol HomeTableViewDataSourceDelegate {
    
    func didSelectRow(index: Int)
}

class HomeTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var items : [MessageVM]
    let tableView: UITableView!
    var delegate: HomeTableViewDataSourceDelegate?
    
    init(items : [MessageVM], tableView: UITableView, delegate: HomeTableViewDataSourceDelegate) {
        self.items = items
        self.tableView = tableView
        self.delegate = delegate

        tableView.registerCell(type: HomeTableViewCell.self)
        
        tableView.contentInsetAdjustmentBehavior = .never
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }
    
    func updateTable(items : [MessageVM]) {
        self.items = items
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let item = items[indexPath.row]
        let cell = tableView.dequeueCell(withType: HomeTableViewCell.self) as! HomeTableViewCell
        cell.config(item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectRow(index: indexPath.row)
    }
}
