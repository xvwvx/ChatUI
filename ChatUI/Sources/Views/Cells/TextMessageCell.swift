//
//  TextMessageCell.swift
//  ChatUI
//
//  Created by Snow on 2021/5/8.
//

import UIKit

open class TextMessageCell: MessageContentCell {
    
    open override weak var delegate: MessageCellDelegate? {
        didSet {
            messageLabel.delegate = delegate
        }
    }
    
    open var messageLabel = MessageLabel()
    
    // MARK: - Methods

    open override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let attributes = layoutAttributes as? MessagesCollectionViewLayoutAttributes {
            messageLabel.textInsets = attributes.messageLabelInsets
            messageLabel.messageLabelFont = attributes.messageLabelFont
            messageLabel.frame = messageContainerView.bounds
        }
    }

    open override func prepareForReuse() {
        super.prepareForReuse()
        messageLabel.attributedText = nil
        messageLabel.text = nil
    }

    open override func setupSubviews() {
        super.setupSubviews()
        messageContainerView.addSubview(messageLabel)
    }
    
    open override func cellContentView(canHandle touchPoint: CGPoint) -> Bool {
        return messageLabel.handleGesture(touchPoint)
    }
    
}
