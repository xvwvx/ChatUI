//
//  MessagesLayoutDelegate.swift
//  ChatUI
//
//  Created by Snow on 2021/5/8.
//

import UIKit

public protocol MessagesLayoutDelegate: AnyObject {
    
    func headerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize
    
    func footerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize
    
    func nameLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat
    
    func customCellSizeCalculator(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CellSizeCalculator
    
}

public extension MessagesLayoutDelegate {
    func headerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return .zero
    }
    
    func footerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return .zero
    }
    
    func nameLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 16
    }
    
    func customCellSizeCalculator(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CellSizeCalculator {
        fatalError("Must return a CellSizeCalculator for MessageKind.custom(Any?)")
    }
}
