//
//  LoginViewController.swift
//  Ampada
//
//  Created by Mahdi on 12/11/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    
    private let loginViewModel: LoginViewModel
    
    init(_ loginViewModel: LoginViewModel) {
        
        self.loginViewModel = loginViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        emailTextField.text = "mahdi4@bukhariansiddur.com"
        passwordTextField.text = "12345"

    }
    
    @IBAction func signInAction(_ sender: Any) {
        
        let userName = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        loginViewModel.signIn(userName: userName, password: password)
    }
    
    @IBAction func signUpAction(_ sender: Any) {

        let view = SignUpViewController(.init(loginViewModel.emailRepository))
        self.navigationController?.pushViewController(view, animated: true)
    }
}

//MARK: - UITextField Delegate
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
