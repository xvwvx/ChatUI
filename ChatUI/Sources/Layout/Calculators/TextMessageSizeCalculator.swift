//
//  TextMessageSizeCalculator.swift
//  ChatUI
//
//  Created by Snow on 2021/5/8.
//

import UIKit

open class TextMessageSizeCalculator: MessageSizeCalculator {
    
    public var incomingMessageLabelInsets = UIEdgeInsets(top: 8.5, left: 19, bottom: 8.5, right: 9)
    public var outgoingMessageLabelInsets = UIEdgeInsets(top: 8.5, left: 9, bottom: 8.5, right: 19)

    public var messageLabelFont = UIFont.systemFont(ofSize: 14)
    
    internal func messageLabelInsets(for message: MessageType) -> UIEdgeInsets {
        let dataSource = messagesLayout.messagesDataSource
        let isFromCurrentSender = dataSource.isFromCurrentSender(message: message)
        return isFromCurrentSender ? outgoingMessageLabelInsets : incomingMessageLabelInsets
    }

    open override func messageContainerMaxWidth(for message: MessageType) -> CGFloat {
        let maxWidth = super.messageContainerMaxWidth(for: message)
        let textInsets = messageLabelInsets(for: message)
        return maxWidth - textInsets.left - textInsets.right
    }
    
    open override func messageContainerSize(for message: MessageType) -> CGSize {
        let maxWidth = messageContainerMaxWidth(for: message)

        var messageContainerSize: CGSize
        let attributedText: NSAttributedString

        let textMessageKind = message.kind
        switch textMessageKind {
        case .text(let text):
            attributedText = NSAttributedString(string: text, attributes: [.font: messageLabelFont])
        default:
            fatalError("messageContainerSize received unhandled MessageDataType: \(message.kind)")
        }

        messageContainerSize = labelSize(for: attributedText, considering: maxWidth)

        let messageInsets = messageLabelInsets(for: message)
        messageContainerSize.width += messageInsets.left + messageInsets.right
        messageContainerSize.height += messageInsets.top + messageInsets.bottom

        return messageContainerSize
    }

//    open override func configure(attributes: UICollectionViewLayoutAttributes) {
//        super.configure(attributes: attributes)
//        guard let attributes = attributes as? MessagesCollectionViewLayoutAttributes else { return }
//
//        let dataSource = messagesLayout.messagesDataSource
//        let indexPath = attributes.indexPath
//        let message = dataSource.messageForItem(at: indexPath, in: messagesLayout.messagesCollectionView)
//
//        attributes.messageLabelInsets = messageLabelInsets(for: message)
//        attributes.messageLabelFont = messageLabelFont
//
//        switch message.kind {
//        case .attributedText(let text):
//            guard !text.string.isEmpty else { return }
//            guard let font = text.attribute(.font, at: 0, effectiveRange: nil) as? UIFont else { return }
//            attributes.messageLabelFont = font
//        default:
//            break
//        }
//    }
    
}
