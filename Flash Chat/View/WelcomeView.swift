//
//  WelcomeView.swift
//  Flash Chat
//
//  Created by Иван Семенов on 03.04.2024.
//

import UIKit
import SnapKit
import CLTypingLabel

class WelcomeView: UIView {

    let label: CLTypingLabel = {
        let element = CLTypingLabel()
        element.font = .systemFont(ofSize: 42, weight: .bold)
        element.textColor = UIColor(named: Constants.BrandColors.blue)
        return element
    }()
    let registerButton: UIButton = {
        let element = UIButton()
        element.setTitle("Register", for: .normal)
        element.setTitleColor(UIColor(named: Constants.BrandColors.blue), for: .normal)
        element.backgroundColor = UIColor(named: Constants.BrandColors.lighBlue)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        element.layer.borderWidth = 1
        element.layer.borderColor = UIColor(named: Constants.BrandColors.blue)?.cgColor
        element.layer.cornerRadius = 12
        return element
    }()
    let loginButton: UIButton = {
        let element = UIButton()
        element.setTitle("Login", for: .normal)
        element.tintColor = .white
        element.backgroundColor = UIColor(named: Constants.BrandColors.blue)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        element.layer.cornerRadius = 12
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(label)
        addSubview(registerButton)
        addSubview(loginButton)
    }
    
    private func addConstraints() {
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-40)
        }
        
        registerButton.snp.makeConstraints { make in
            make.bottom.equalTo(loginButton.snp.top).offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(60)
        }
        
        loginButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(60)
        }
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
import SwiftUI

struct WelcomeViewProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().ignoresSafeArea()
    }
    struct ContainerView: UIViewRepresentable {
        let view = WelcomeView()
        
        func makeUIView(context: Context) -> some UIView {
            return view
        }
        func updateUIView(_ uiView: UIViewType, context: Context) { }
    }
}
