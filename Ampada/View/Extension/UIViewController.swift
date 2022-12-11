//
//  UIViewController.swift
//  Ampada
//
//  Created by Mahdi on 12/11/22.
//

import UIKit

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func presentCross(_ viewControllerToPresent: UIViewController) {
            
        let view = viewControllerToPresent
        view.modalPresentationStyle = .overCurrentContext
        view.modalTransitionStyle   = .crossDissolve
        present(view, animated: true, completion: nil)
    }
}
