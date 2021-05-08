//
//  Message.swift
//  ChatUI
//
//  Created by Snow on 2021/5/8.
//

import Foundation


struct User: SenderType, Equatable {
    var avatarUrl: URL?
    var senderId: String
    var displayName: String
}

class Message: MessageType {
    
    var senderID: String
    
    var messageId: String
    
    var sentDate: Date
    
    var kind: MessageKind
    
    private init(kind: MessageKind, senderID: String, messageId: String, date: Date) {
        self.kind = kind
        self.senderID = senderID
        self.messageId = messageId
        self.sentDate = date
    }
    
    convenience init(text: String, senderID: String, messageId: String, date: Date) {
        self.init(kind: .text(text), senderID: senderID, messageId: messageId, date: date)
    }
    
    convenience init(attributedText: NSAttributedString, senderID: String, messageId: String, date: Date) {
        self.init(kind: .attributedText(attributedText), senderID: senderID, messageId: messageId, date: date)
    }
    
}
