//
//  MessagesCollectionViewLayoutAttributes.swift
//  ChatUI
//
//  Created by Snow on 2021/5/8.
//

import UIKit

open class MessagesCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    
    public enum Orientation {
        case incoming
        case outgoing
    }
    
    public var orientation = Orientation.outgoing
    
    public var avatarCornerRadius: CGFloat = 0
    public var avatarSize: CGSize = .zero
    public var avatarLeadingTrailingPadding: CGFloat = 0
    
    public var nameLabelAlignment = LabelAlignment(textAlignment: .center, textInsets: .zero)
    public var nameLabelSize: CGSize = .zero
    
    public var messageContainerSize: CGSize = .zero
    public var messageContainerPadding: UIEdgeInsets = .zero
    public var messageLabelFont: UIFont = UIFont.preferredFont(forTextStyle: .body)
    public var messageLabelInsets: UIEdgeInsets = .zero

    // MARK: - Methods

    open override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! MessagesCollectionViewLayoutAttributes
        copy.orientation = orientation
        
        copy.avatarCornerRadius = avatarCornerRadius
        copy.avatarSize = avatarSize
        copy.avatarLeadingTrailingPadding = avatarLeadingTrailingPadding
        
        copy.nameLabelAlignment = nameLabelAlignment
        copy.nameLabelSize = nameLabelSize
        
        copy.messageContainerSize = messageContainerSize
        copy.messageContainerPadding = messageContainerPadding
        copy.messageLabelFont = messageLabelFont
        copy.messageLabelInsets = messageLabelInsets
        
        return copy
    }
    
    open override func isEqual(_ object: Any?) -> Bool {
        guard let attributes = object as? MessagesCollectionViewLayoutAttributes else { return false }
        
        return super.isEqual(attributes)
            && attributes.orientation == orientation
            
            && attributes.avatarCornerRadius == avatarCornerRadius
            && attributes.avatarSize == avatarSize
            && attributes.avatarLeadingTrailingPadding == avatarLeadingTrailingPadding
            
            && attributes.nameLabelAlignment == nameLabelAlignment
            && attributes.nameLabelSize == nameLabelSize
        
            && attributes.messageContainerSize == messageContainerSize
            && attributes.messageContainerPadding == messageContainerPadding
            && attributes.messageLabelFont == messageLabelFont
            && attributes.messageLabelInsets == messageLabelInsets
    }
}
