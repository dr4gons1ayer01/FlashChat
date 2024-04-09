//
//  LoginViewController.swift
//  Flash Chat
//
//  Created by Иван Семенов on 03.04.2024.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = loginView
        addActions()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loginView.emailTextField.text = "1@2.com"
        loginView.passwordTextField.text = "123456"
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        loginView.emailTextField.text = ""
//        loginView.passwordTextField.text = ""
//    }
    
    func addActions() {
        let chatTap = UIAction { [weak self] tap in
            guard let self = self else { return }
            
            guard let email = loginView.emailTextField.text, !email.isEmpty else {
                print("Email is empty")
                return
            }
            guard let password = loginView.passwordTextField.text, !password.isEmpty else {
                print("Password is empty")
                return
            }
            
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
              guard let self = self else { return }
                if let error = error {
                    print("Error creating user:", error)
                } else {
                    print("User signed in successfully")
                    let vc = ChatViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
        loginView.loginButton.addAction(chatTap, for: .touchUpInside)
    }
}

