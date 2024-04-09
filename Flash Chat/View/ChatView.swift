//
//  ChatView.swift
//  Flash Chat
//
//  Created by Иван Семенов on 03.04.2024.
//

import UIKit
import SnapKit

class ChatView: UIView {

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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: Constants.BrandColors.purple)
        addSubviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(messageTF)
        addSubview(sendButton)
    }
    
    private func addConstraints() {

        messageTF.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(sendButton.snp.leading).offset(-20)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.height.equalTo(40)
        }
        
        sendButton.snp.makeConstraints { make in
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
