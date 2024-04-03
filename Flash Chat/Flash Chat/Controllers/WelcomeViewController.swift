//
//  WelcomeViewController.swift
//  Flash Chat
//
//  Created by Иван Семенов on 03.04.2024.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    let welcomeView = WelcomeView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = welcomeView
        addAction()
        
    }

    func addAction() {
        let registerTap = UIAction { tap in
            let vc = RegisterViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        welcomeView.registerButton.addAction(registerTap, for: .touchUpInside)
        
        let loginTap = UIAction { tap in
            let vc = LoginViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        welcomeView.loginButton.addAction(loginTap, for: .touchUpInside)
    }
    
}


