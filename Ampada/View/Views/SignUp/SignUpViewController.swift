//
//  SignUpViewController.swift
//  Ampada
//
//  Created by Mahdi on 12/12/22.
//

import UIKit
import Combine

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    @IBOutlet weak var domainPickerView  : UIPickerView!
    
    private let signUpViewModel: SignUpViewModel
    private var subscriptions = Set<AnyCancellable>()
    var domains = [DomainVM]()
    var currentDomain : DomainVM?
    
    init(_ signUpViewModel: SignUpViewModel) {
        
        self.signUpViewModel = signUpViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        domainPickerView.delegate = self
        domainPickerView.dataSource = self
        
        signUpViewModel.getDomains()
        .sink(receiveValue: { [weak self] value in
                
            self?.domains = value
            self?.currentDomain = value.first
            self?.domainPickerView.reloadAllComponents()
                
        }).store(in: &subscriptions)
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        
        guard let userName = usernameTextField.text as? String else {
            
            return
        }
        
        guard let password = passwordTextField.text as? String else {
            
            return
        }
        
        guard let domain = currentDomain else {
            
            return
        }
        
        signUpViewModel.signUp(userName: userName, password: password, domainVM: domain)
    }
}

//MARK: - UITextField Delegate
extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: - UIPickerView DataSource, Delegate
extension SignUpViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return domains.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 12)
        label.text = domains[row].title
        label.textAlignment = .center
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentDomain = domains[row]
    }
}

