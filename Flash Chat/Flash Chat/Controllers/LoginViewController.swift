//
//  LoginViewController.swift
//  Flash Chat
//
//  Created by Иван Семенов on 03.04.2024.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = loginView
        
    }
    
}
