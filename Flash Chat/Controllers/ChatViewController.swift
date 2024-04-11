//
//  ChatViewController.swift
//  Flash Chat
//
//  Created by Иван Семенов on 03.04.2024.
//

import UIKit
import SnapKit
import Firebase

class ChatViewController: UIViewController {
        
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
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            guard !self.messages.isEmpty else { return }
                            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                        }
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
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.meImageView.isHidden = false
            cell.youImageView.isHidden = true
            cell.messageLabel.text = message.body
            cell.messageBubbleView.backgroundColor = UIColor(named: Constants.BrandColors.lightPurple)
            cell.messageLabel.textColor = UIColor(named: Constants.BrandColors.purple)
            
            
        } else {
            cell.meImageView.isHidden = true
            cell.youImageView.isHidden = false
            cell.messageLabel.text = message.body
            cell.messageBubbleView.backgroundColor = UIColor(named: Constants.BrandColors.purple)
            cell.messageLabel.textColor = .white
            
            
        }
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
