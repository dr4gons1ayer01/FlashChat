//
//  MessageCell.swift
//  Flash Chat
//
//  Created by Иван Семенов on 08.04.2024.
//

import UIKit
import SnapKit

class MessageCell: UITableViewCell {

    let messageBubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: Constants.BrandColors.purple)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: Constants.BrandColors.purple)?.cgColor
        view.layer.cornerRadius = 20
        return view
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello"
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    let youImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "anna")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let meImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ivan")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(messageBubbleView)
        messageBubbleView.addSubview(messageLabel)
        contentView.addSubview(youImageView)
        contentView.addSubview(meImageView)
    }

    private func setupConstraints() {
        messageLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        youImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        meImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        messageBubbleView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.equalTo(youImageView.snp.trailing).offset(10)
            make.trailing.equalTo(meImageView.snp.leading).offset(-10)
            
        }
    }
}

import SwiftUI

struct MessageCellProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().ignoresSafeArea()
    }
    struct ContainerView: UIViewRepresentable {
        let view = MessageCell()
        
        func makeUIView(context: Context) -> some UIView {
            return view
        }
        func updateUIView(_ uiView: UIViewType, context: Context) { }
    }
}
