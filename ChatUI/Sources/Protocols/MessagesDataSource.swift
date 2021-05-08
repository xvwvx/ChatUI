//
//  MessagesDataSource.swift
//  ChatUI
//
//  Created by Snow on 2021/5/8.
//

import UIKit

public protocol MessagesDataSource: AnyObject {
    
    func sender(message: MessageType) -> SenderType?
    
    func currentSenderID() -> String
    
    func isFromCurrentSender(message: MessageType) -> Bool
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int
    
    func numberOfItems(inSection section: Int, in messagesCollectionView: MessagesCollectionView) -> Int
    
    func customCell(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UICollectionViewCell
    
}

public extension MessagesDataSource {

    func isFromCurrentSender(message: MessageType) -> Bool {
        return message.senderID == currentSenderID()
    }
    
    func numberOfItems(inSection section: Int, in messagesCollectionView: MessagesCollectionView) -> Int {
        return 1
    }
    
}
