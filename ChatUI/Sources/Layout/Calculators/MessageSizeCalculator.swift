//
//  MessageSizeCalculator.swift
//  ChatUI
//
//  Created by Snow on 2021/5/8.
//

import UIKit

open class MessageSizeCalculator: CellSizeCalculator {
    
    public init(layout: MessagesCollectionViewFlowLayout? = nil) {
        super.init()
        
        self.layout = layout
    }
    
    public var avatarCornerRadius: CGFloat = 23
    public var avatarSize: CGSize = CGSize(width: 46, height: 46)
    public var avatarLeadingTrailingPadding: CGFloat = 4
    
    public var incomingNameLabelAlignment = LabelAlignment(textAlignment: .left,
                                                           textInsets: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
    public var outgoingNameLabelAlignment = LabelAlignment(textAlignment: .right,
                                                           textInsets: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
    
    public var incomingMessagePadding = UIEdgeInsets.zero
    public var outgoingMessagePadding = UIEdgeInsets.zero
    
    open override func configure(attributes: UICollectionViewLayoutAttributes) {
        guard let attributes = attributes as? MessagesCollectionViewLayoutAttributes else { return }
        
        attributes.orientation = attributes.indexPath.row % 2 == 0 ? .incoming : .outgoing
        
        attributes.avatarCornerRadius = avatarCornerRadius
        attributes.avatarSize = avatarSize
        attributes.avatarLeadingTrailingPadding = avatarLeadingTrailingPadding
        
        switch attributes.orientation {
        case .incoming:
            attributes.nameLabelAlignment = incomingNameLabelAlignment
        case .outgoing:
            attributes.nameLabelAlignment = outgoingNameLabelAlignment
        }
        
        let contentWidth = messagesLayout.itemWidth - (avatarSize.width + avatarLeadingTrailingPadding) * 2
        
        let nameHeight: CGFloat = 16
        attributes.nameLabelSize = CGSize(width: contentWidth, height: nameHeight)
    }
    
    open override func sizeForItem(at indexPath: IndexPath) -> CGSize {
        let dataSource = messagesLayout.messagesDataSource
        let message = dataSource.messageForItem(at: indexPath, in: messagesLayout.messagesCollectionView)
        let itemHeight = cellContentHeight(for: message, at: indexPath)
        return CGSize(width: messagesLayout.itemWidth, height: itemHeight)
    }

    open func cellContentHeight(for message: MessageType, at indexPath: IndexPath) -> CGFloat {
        let nameLabelHeight = nameSize(for: message).height
        let messageContainerHeight = messageContainerSize(for: message).height
        let messageVerticalPadding = messageContainerPadding(for: message)
        
        return nameLabelHeight + messageVerticalPadding.top + messageContainerHeight + messageVerticalPadding.bottom
    }
    
    // MARK: - Name
    open func nameSize(for message: MessageType) -> CGSize {
        let contentWidth = messagesLayout.itemWidth - (avatarSize.width + avatarLeadingTrailingPadding) * 2
        let nameHeight: CGFloat = 16
        return CGSize(width: contentWidth, height: nameHeight)
    }
    
    // MARK: - Avatar

    open func avatarSize(for message: MessageType) -> CGSize {
        return avatarSize
    }
    
    // MARK: - MessageContainer

    open func messageContainerPadding(for message: MessageType) -> UIEdgeInsets {
        let dataSource = messagesLayout.messagesDataSource
        let isFromCurrentSender = dataSource.isFromCurrentSender(message: message)
        return isFromCurrentSender ? outgoingMessagePadding : incomingMessagePadding
    }

    open func messageContainerSize(for message: MessageType) -> CGSize {
        return .zero
    }

    open func messageContainerMaxWidth(for message: MessageType) -> CGFloat {
        let avatarWidth = avatarSize(for: message).width
        return messagesLayout.itemWidth - (avatarWidth + avatarLeadingTrailingPadding) * 2
    }
    
    
    // MARK: - Helpers

    public var messagesLayout: MessagesCollectionViewFlowLayout {
        guard let layout = layout as? MessagesCollectionViewFlowLayout else {
            fatalError("Layout object is missing or is not a MessagesCollectionViewFlowLayout")
        }
        return layout
    }

    internal func labelSize(for attributedText: NSAttributedString, considering maxWidth: CGFloat) -> CGSize {
        let constraintBox = CGSize(width: maxWidth, height: .greatestFiniteMagnitude)
        let rect = attributedText.boundingRect(with: constraintBox,
                                               options: [.usesLineFragmentOrigin, .usesFontLeading],
                                               context: nil)
            .integral

        return rect.size
    }
}
