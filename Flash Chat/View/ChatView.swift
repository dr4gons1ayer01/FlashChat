//
//  ChatView.swift
//  Flash Chat
//
//  Created by Иван Семенов on 03.04.2024.
//

import UIKit
import SnapKit

class ChatView: UIView {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        // Настройки таблицы (например, регистрация ячейки, делегат и источник данных) можно добавить здесь
        return tableView
    }()
    
    private let messageTF: UITextField = {
        let element = UITextField()
        element.placeholder = "Message"
        element.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        element.leftViewMode = .always
        element.borderStyle = .roundedRect
        return element
    }()
    
    private let bookButton: UIButton = {
        let element = UIButton()
        element.setImage(UIImage(systemName: "airplane"), for: .normal)
        element.tintColor = .white
        element.backgroundColor = UIColor(named: "BrandBlue")
        element.layer.cornerRadius = 12
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "BrandPurple")
        addSubviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(tableView)
        addSubview(messageTF)
        addSubview(bookButton)
    }
    
    private func addConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(messageTF.snp.top).offset(-20)
        }
        
        messageTF.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(bookButton.snp.leading).offset(-20)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.height.equalTo(40)
        }
        
        bookButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalTo(messageTF)
            make.width.height.equalTo(40) 
        }
    }
}

import SwiftUI

struct ChatViewProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().ignoresSafeArea()
    }
    struct ContainerView: UIViewRepresentable {
        let view = ChatView()
        
        func makeUIView(context: Context) -> some UIView {
            return view
        }
        func updateUIView(_ uiView: UIViewType, context: Context) { }
    }
}
