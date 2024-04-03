//
//  RegisterView.swift
//  Flash Chat
//
//  Created by Иван Семенов on 03.04.2024.
//

import UIKit
import SnapKit

class RegisterView: UIView {
    
    private let emailTextField: UITextField = {
        let element = UITextField()
        element.placeholder = "Email"
        element.font = UIFont.systemFont(ofSize: 20)
        element.backgroundColor = UIColor(named: "BrandLightPurple")
        element.layer.borderWidth = 1
        element.layer.borderColor = UIColor(named: "BrandBlue")?.cgColor
        element.layer.cornerRadius = 12
        element.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        element.leftViewMode = .always
        element.borderStyle = .roundedRect
        return element
    }()
    
    private let passwordTextField: UITextField = {
        let element = UITextField()
        element.placeholder = "Password"
        element.font = UIFont.systemFont(ofSize: 20)
        element.backgroundColor = UIColor(named: "BrandLightPurple")
        element.layer.borderWidth = 1
        element.layer.borderColor = UIColor(named: "BrandBlue")?.cgColor
        element.layer.cornerRadius = 12
        element.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        element.leftViewMode = .always
        element.borderStyle = .roundedRect
        element.isSecureTextEntry = true // Для скрытия введенного текста
        return element
    }()
    
    private let registerButton: UIButton = {
        let element = UIButton()
        element.setTitle("Register", for: .normal)
        element.setTitleColor(.white, for: .normal)
        element.backgroundColor = UIColor(named: "BrandBlue")
        element.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        element.layer.cornerRadius = 12
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "BrandLightBlue")
        addSubviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(registerButton)
    }
    
    private func addConstraints() {
        emailTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.trailing.height.equalTo(emailTextField)
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.leading.trailing.height.equalTo(emailTextField)
        }
    }
}
import SwiftUI

struct RegisterViewProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().ignoresSafeArea()
    }
    struct ContainerView: UIViewRepresentable {
        let view = RegisterView()
        
        func makeUIView(context: Context) -> some UIView {
            return view
        }
        func updateUIView(_ uiView: UIViewType, context: Context) { }
    }
}
