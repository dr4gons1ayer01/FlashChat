//
//  RegisterViewController.swift
//  Flash Chat
//
//  Created by Иван Семенов on 03.04.2024.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let registerView = RegisterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = registerView
        
    }
    
}
