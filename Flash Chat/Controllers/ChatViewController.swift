//
//  ChatViewController.swift
//  Flash Chat
//
//  Created by Иван Семенов on 03.04.2024.
//

import UIKit

class ChatViewController: UIViewController {
    
    let chatView = ChatView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = chatView
        
    }
    
}
