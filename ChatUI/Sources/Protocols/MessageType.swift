//
//  MessageType.swift
//  ChatUI
//
//  Created by Snow on 2021/5/8.
//

import Foundation

public protocol MessageType {
    
    var senderID: String { get }
    
    var messageId: String { get }
    
    var sentDate: Date { get }
    
    var kind: MessageKind { get }
    
}
