//
//  Constants.swift
//  Flash Chat
//
//  Created by Иван Семенов on 07.04.2024.
//

struct Constants {
    static let cellIdentifier = "ReusableCell"
//    static let cellNibName = "MessageCell"
//    static let registerSegue = "RegisterToChat"
//    static let loginSegue = "LoginToChat"
    static let appName = "⚡FlashChat"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}

