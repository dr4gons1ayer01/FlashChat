//
//  ChatViewController.swift
//  Flash Chat
//
//  Created by Иван Семенов on 03.04.2024.
//

import UIKit
import SnapKit
import Firebase
import IQKeyboardManagerSwift

class ChatViewController: UIViewController {
    
//    let chatView = ChatView()

    let messageTF: UITextField = {
        let element = UITextField()
        element.placeholder = "Message"
        element.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        element.leftViewMode = .always
        element.borderStyle = .roundedRect
        return element
    }()
    
    let sendButton: UIButton = {
        let element = UIButton()
        element.setImage(UIImage(systemName: "airplane"), for: .normal)
        element.tintColor = .white
        element.backgroundColor = UIColor(named: Constants.BrandColors.blue)
        element.layer.cornerRadius = 12
        return element
    }()
    
    let db = Firestore.firestore() //ссылка на Firestore
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150 //оценочная высота ячейки
        return tableView
    }()
    
    var messages: [Message] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        title = Constants.appName

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MessageCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        setupNavigationBar()
        addConstraints()
        sendMessage()
        loadMessages()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared.enable = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared.enable = false
    }
    
    private func loadMessages() {
        
        db.collection(Constants.FStore.collectionName)
            .order(by: Constants.FStore.dateField) ///сортировка по дате
            .addSnapshotListener { querySnapshot, error in
                
                self.messages = [] ///очищаем массив и добавляем новое сообщение
                if let error = error {
                    print("there was an issue retrieving data from firestore \(error)")
                } else {
                    if let snapshot = querySnapshot?.documents {
                        for doc in snapshot {
                            let data = doc.data()
                            if let sender = data[Constants.FStore.senderField] as? String,
                               let body = data[Constants.FStore.bodyField] as? String {
                                let newMessage = Message(sender: sender, body: body)
                                self.messages.append(newMessage)
                            }
                        }
                        self.tableView.reloadData()
                    }
                }
            }
    }

    private func addConstraints() {
        view.backgroundColor = UIColor(named: Constants.BrandColors.purple)
        view.addSubview(tableView)
        view.addSubview(messageTF)
        view.addSubview(sendButton)
        
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(messageTF.snp.top)
        }

        messageTF.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(sendButton.snp.leading).offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.height.equalTo(40)
        }

        sendButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalTo(messageTF)
            make.width.height.equalTo(40)
        }
        
//        tableView.snp.makeConstraints { make in
//            make.top.leading.trailing.equalToSuperview()
//            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-100)
//        }
//        
//        let container = UIView()
//        container.backgroundColor = UIColor(named: Constants.BrandColors.purple)
//        view.addSubview(container)
//        container.snp.makeConstraints { make in
//            make.leading.trailing.bottom.equalToSuperview()
//            make.height.equalTo(100)
//        }
//        
//        container.addSubview(messageTF)
//        messageTF.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(20)
//            make.centerY.equalToSuperview()
//            make.width.equalToSuperview().multipliedBy(0.6)
//        }
//        
//        container.addSubview(sendButton)
//        sendButton.snp.makeConstraints { make in
//            make.trailing.equalToSuperview().offset(-20)
//            make.centerY.equalToSuperview()
//            make.width.equalTo(80)
//            make.height.equalTo(40)
//        }
        
    }

    private func sendMessage() {
        let sendTap = UIAction { [self] tap in
            if let messageBody = self.messageTF.text, let messageSender = Auth.auth().currentUser?.email {
                db.collection(Constants.FStore.collectionName).addDocument(data: [Constants.FStore.senderField: messageSender,
                                                                                   Constants.FStore.bodyField: messageBody,
                                                                                   Constants.FStore.dateField: Date.timeIntervalSinceReferenceDate
                ]) { error in
                    if let error = error {
                        print("ошибка firestore: -\(error)")
                    } else {
                        print("successfully saved data")
                        self.messageTF.text = ""
                    }
                }
            }
        }
        sendButton.addAction(sendTap, for: .touchUpInside)
    }

    private func setupNavigationBar() {
        let exitButton = UIBarButtonItem(title: "Exit", style: .plain, target: self, action: #selector(exitButtonTapped))
        navigationItem.rightBarButtonItem = exitButton
        navigationController?.navigationBar.tintColor = UIColor(named: Constants.BrandColors.purple)   //.white
        navigationItem.hidesBackButton = true
    }

    @objc private func exitButtonTapped() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

//MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MessageCell
        cell.selectionStyle = .none

        let message = messages[indexPath.row]
        cell.messageLabel.text = message.body

        return cell
    }
}

//MARK: - UITableViewDelegate
extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


//import UIKit
//import SnapKit
//import Firebase
//
//class ChatViewController: UIViewController {
//    
//    let messageTF: UITextField = {
//        let element = UITextField()
//        element.placeholder = "Message"
//        element.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
//        element.leftViewMode = .always
//        element.borderStyle = .roundedRect
//        return element
//    }()
//    
//    let sendButton: UIButton = {
//        let element = UIButton()
//        element.setImage(UIImage(systemName: "airplane"), for: .normal)
//        element.tintColor = .white
//        element.backgroundColor = UIColor(named: Constants.BrandColors.blue)
//        element.layer.cornerRadius = 12
//        return element
//    }()
//    
//    let db = Firestore.firestore()      //ссылка на Firestore
//    
//    let tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.separatorStyle = .none
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 150      //оценочная высота ячейки
//        return tableView
//    }()
//    
//    var messages: [Message] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        title = Constants.appName
//        
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(MessageCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
//        setupNavigationBar()
//        addConstraints()
//        sendMessage()
//        loadMessages()
//        
//        
//    }
//    
//    private func loadMessages() {
//        
//        db.collection(Constants.FStore.collectionName)
//            .order(by: Constants.FStore.dateField)  ///сортировка по  дате
//            .addSnapshotListener { querySnapshot, error in
//                
//            self.messages = []                      ///очищаем массив и добавляем новое сообщение
//            if let error = error  {
//                print("there was an issue retrieving data from firestore \(error)")
//            } else {
//                if let snapshot = querySnapshot?.documents {
//                    for doc in snapshot {
//                        let data = doc.data()
//                        if let sender = data[Constants.FStore.senderField] as? String,
//                           let body = data[Constants.FStore.bodyField] as? String {
//                            let newMessage = Message(sender: sender, body: body)
//                            self.messages.append(newMessage)
//                        }
//                    }
//                    self.tableView.reloadData()
//                }
//            }
//        }
//    }
//    
//    private func addConstraints() {
//        view.addSubview(tableView)
//        tableView.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
//            make.leading.trailing.equalToSuperview()
//            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-100) 
//        }
//        
//        view.addSubview(messageTF)
//        messageTF.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(20)
//            make.trailing.equalTo(sendButton.snp.leading).offset(-20)
//            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
//            make.height.equalTo(40)
//        }
//        
//        view.addSubview(sendButton)
//        sendButton.snp.makeConstraints { make in
//            make.trailing.equalToSuperview().offset(-20)
//            make.centerY.equalTo(messageTF)
//            make.width.height.equalTo(40)
//        }
//        
//    }
//    
//    private func sendMessage() {
//        let sendTap = UIAction { [self] tap in
//            if let messageBody = self.messageTF.text, let messageSender = Auth.auth().currentUser?.email {
//                db.collection(Constants.FStore.collectionName).addDocument(data: [Constants.FStore.senderField: messageSender,
//                                                                                  Constants.FStore.bodyField: messageBody,
//                                                                                  Constants.FStore.dateField: Date.timeIntervalSinceReferenceDate
//                                                                                 ]) { error in
//                    if let error = error {
//                        print("ошибка firestore: -\(error)")
//                    } else {
//                        print("successfully saved data")
//                        self.messageTF.text = ""
//                    }
//                }
//            }
//        }
//        sendButton.addAction(sendTap, for: .touchUpInside)
//    }
//    
//    private func setupNavigationBar() {
//        let exitButton = UIBarButtonItem(title: "Exit", style: .plain, target: self, action: #selector(exitButtonTapped))
//        navigationItem.rightBarButtonItem = exitButton
//        navigationController?.navigationBar.tintColor = .white
//        navigationItem.hidesBackButton = true
//    }
//    
//    @objc private func exitButtonTapped() {
//        let firebaseAuth = Auth.auth()
//        do {
//          try firebaseAuth.signOut()
//            self.navigationController?.popToRootViewController(animated: true)
//        } catch let signOutError as NSError {
//          print("Error signing out: %@", signOutError)
//        }
//    }
//}
////MARK: - UITableViewDataSource
//extension ChatViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return messages.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MessageCell
//        cell.selectionStyle = .none
//        
//        let message = messages[indexPath.row]
//        cell.messageLabel.text = message.body
//        
//        
//        return cell
//    }
//}
////MARK: - UITableViewDelegate
//extension ChatViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//    
//}
