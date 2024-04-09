//
//  MessageCell.swift
//  Flash Chat
//
//  Created by Иван Семенов on 08.04.2024.
//

import UIKit

class MessageCell: UITableViewCell {
    
    let messageBubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: Constants.BrandColors.purple)
        view.layer.cornerRadius = 12 
        return view
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello"
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "MeAvatar")
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
        contentView.addSubview(avatarImageView)
    }
    
    private func setupConstraints() {
        messageBubbleView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(10)
            make.trailing.equalTo(avatarImageView.snp.leading).offset(-10)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().offset(-10)
            make.width.height.equalTo(40)
        }
    }
}

