//
//  WelcomeView.swift
//  Flash Chat
//
//  Created by Иван Семенов on 03.04.2024.
//

import UIKit
import SnapKit

class WelcomeView: UIView {
    
    private let lightningSymbol: UIImageView = {
        let element = UIImageView(image: UIImage(systemName: "bolt.fill"))
        element.tintColor = .systemYellow
        return element
    }()
    private let label: UILabel = {
        let element = UILabel()
        element.text = "FlashChat"
        element.font = .systemFont(ofSize: 42, weight: .bold)
        element.textColor = UIColor(named: "BrandBlue")
        return element
    }()
    let registerButton: UIButton = {
        let element = UIButton()
        element.setTitle("Register", for: .normal)
        element.setTitleColor(UIColor(named: "BrandBlue"), for: .normal)
        element.backgroundColor = UIColor(named: "BrandLightBlue")
        element.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        element.layer.borderWidth = 1
        element.layer.borderColor = UIColor(named: "BrandBlue")?.cgColor
        element.layer.cornerRadius = 12
        return element
    }()
    let loginButton: UIButton = {
        let element = UIButton()
        element.setTitle("Login", for: .normal)
        element.tintColor = .white
        element.backgroundColor = UIColor(named: "BrandBlue")
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
        addSubview(lightningSymbol)
        addSubview(label)
        addSubview(registerButton)
        addSubview(loginButton)
    }
    
    private func addConstraints() {
        lightningSymbol.snp.makeConstraints { make in
            make.trailing.equalTo(label.snp.leading).offset(-10)
            make.centerY.equalTo(label)
            make.width.height.equalTo(42)
        }
        
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
