//
//  WelcomeViewController.swift
//  Flash Chat
//
//  Created by Иван Семенов on 03.04.2024.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {
    
    let welcomeView = WelcomeView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = welcomeView
        addAction()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startAnimating()
    }
    
    func startAnimating() {
        welcomeView.label.text = Constants.appName
    }
    
//    func startAnimating() {
//        welcomeView.label.text = ""
//        var charIndex = 0.0
//        let labelText = "⚡FlashChat"
//        for letter in labelText {
//            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { timer in
//                self.welcomeView.label.text?.append(letter)
//            }
//            charIndex += 1
//        }
//    }

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


