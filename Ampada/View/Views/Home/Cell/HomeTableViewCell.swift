//
//  HomeTableViewCell.swift
//  Ampada
//
//  Created by Mahdi on 12/13/22.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var symbolLabel : UILabel!
    @IBOutlet weak var userNameLabel : UILabel!
    @IBOutlet weak var subjectLabel : UILabel!
    @IBOutlet weak var introLabel : UILabel!
    
    func config(_ message: MessageVM) {
        
        let char = message.user.first ?? Character("-")
        symbolLabel.text = "\(char)".capitalized
        userNameLabel.text = message.user.capitalized
        subjectLabel.text = message.subject
        introLabel.text = message.intro
    }
}
