//
//  RegisterViewController.swift
//  Flash Chat
//
//  Created by Иван Семенов on 03.04.2024.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    let registerView = RegisterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = registerView
        addActions()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        registerView.emailTextField.text = ""
        registerView.passwordTextField.text = ""
    }
    
    func addActions() {
        let chatTap = UIAction { [weak self] tap in
            guard let self = self else { return }
            
            guard let email = registerView.emailTextField.text, !email.isEmpty else {
                print("Email is empty")
                return
            }
            guard let password = registerView.passwordTextField.text, !password.isEmpty else {
                print("Password is empty")
                return
            }
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    print("Error creating user:", error)
                } else {
                    print("User created successfully")
                    
                    let vc = ChatViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
        registerView.registerButton.addAction(chatTap, for: .touchUpInside)
    }
}
