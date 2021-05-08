//
//  MessageContentCell.swift
//  ChatUI
//
//  Created by Snow on 2021/5/8.
//

import UIKit

open class MessageContentCell: MessageCollectionViewCell {
    
    open var avatarView: MessageImageView = {
        let avatarView = MessageImageView()
        avatarView.clipsToBounds = true
        avatarView.layer.masksToBounds = true
        return avatarView
    }()
    
    open var nameLabel: InsetLabel = InsetLabel()
    
    open var messageContainerView: MessageContainerView = {
        let containerView = MessageContainerView()
        containerView.clipsToBounds = true
        containerView.layer.masksToBounds = true
        return containerView
    }()
    
    open weak var delegate: MessageCellDelegate?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }
    
    open func setupSubviews() {
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        contentView.addSubview(avatarView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(messageContainerView)
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        avatarView.image = nil
        nameLabel.text = nil
    }
    
    // MARK: - Configuration
    
    open override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        guard let attributes = layoutAttributes as? MessagesCollectionViewLayoutAttributes else { return }
        layoutAvatarView(with: attributes)
        layoutNameLabel(with: attributes)
        layoutMessageContainerView(with: attributes)
    }
    
    open func configure(with message: MessageType, at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView) {
        guard let dataSource = messagesCollectionView.messagesDataSource else {
            fatalError()
        }
        guard let displayDelegate = messagesCollectionView.messagesDisplayDelegate else {
            fatalError()
        }
        
        messageContainerView.image = displayDelegate.bubbleImage(for: message, at: indexPath, in: messagesCollectionView)
        nameLabel.textColor = displayDelegate.nameColor(for: message, at: indexPath, in: messagesCollectionView)
        
    }
    
    open override func handleTapGesture(_ gesture: UIGestureRecognizer) {
        let touchLocation = gesture.location(in: self)
        
        switch true {
        case messageContainerView.frame.contains(touchLocation)
                && !cellContentView(canHandle: convert(touchLocation, to: messageContainerView)):
            delegate?.didTapMessage(in: self)
            print("didTapMessage")
        case avatarView.frame.contains(touchLocation):
            delegate?.didTapAvatar(in: self)
            print("didTapAvatar")
        case nameLabel.frame.contains(touchLocation):
            delegate?.didTapName(in: self)
            print("didTapName")
        default:
            delegate?.didTapBackground(in: self)
            print("didTapBackground")
        }
    }
    
    open override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let touchPoint = gestureRecognizer.location(in: self)
        guard gestureRecognizer.isKind(of: UILongPressGestureRecognizer.self) else { return false }
        return messageContainerView.frame.contains(touchPoint)
    }

    open func cellContentView(canHandle touchPoint: CGPoint) -> Bool {
        return false
    }
    
    // MARK: - Origin Calculations
    
    open func layoutAvatarView(with attributes: MessagesCollectionViewLayoutAttributes) {
        var origin: CGPoint = .zero
        
        switch attributes.orientation {
        case .incoming:
            origin = .zero
        case .outgoing:
            origin.x = bounds.width - attributes.avatarSize.width
        }
        
        avatarView.layer.cornerRadius = attributes.avatarCornerRadius
        avatarView.frame = CGRect(origin: origin, size: attributes.avatarSize)
    }
    
    open func layoutNameLabel(with attributes: MessagesCollectionViewLayoutAttributes) {
        switch attributes.orientation {
        case .incoming:
            nameLabel.isHidden = false
            
            nameLabel.textAlignment = attributes.nameLabelAlignment.textAlignment
            nameLabel.textInsets = attributes.nameLabelAlignment.textInsets
            
            let origin: CGPoint = CGPoint(x: attributes.avatarSize.width + attributes.avatarLeadingTrailingPadding, y: 0)
            nameLabel.frame = CGRect(origin: origin, size: attributes.nameLabelSize)
        case .outgoing:
            nameLabel.isHidden = true
        }
    }
    
    open func layoutMessageContainerView(with attributes: MessagesCollectionViewLayoutAttributes) {
        var origin: CGPoint = CGPoint(x: 0, y: nameLabel.bounds.maxY + attributes.messageContainerPadding.top)
        switch attributes.orientation {
        case .incoming:
            origin.x = attributes.avatarSize.width
                + attributes.avatarLeadingTrailingPadding
                + attributes.messageContainerPadding.left
        case .outgoing:
            origin.x = bounds.width
                - attributes.avatarSize.width
                - attributes.avatarLeadingTrailingPadding
                - attributes.messageContainerPadding.right
                - attributes.messageContainerSize.width
        }
        messageContainerView.frame = CGRect(origin: origin, size: attributes.messageContainerSize)
    }
}
