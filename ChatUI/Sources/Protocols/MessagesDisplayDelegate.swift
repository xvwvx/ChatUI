//
//  MessagesDisplayDelegate.swift
//  ChatUI
//
//  Created by Snow on 2021/5/8.
//

import UIKit

public protocol MessagesDisplayDelegate: AnyObject {
    
    func nameColor(for message: MessageType, at  indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor
    
    func bubbleImage(for message: MessageType, at  indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIImage?
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor
    
}

