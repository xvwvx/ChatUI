//
//  MessageCellDelegate.swift
//  ChatUI
//
//  Created by Snow on 2021/5/8.
//

import Foundation

public protocol MessageCellDelegate: MessageLabelDelegate {
    
    func didTapBackground(in cell: MessageCollectionViewCell)
    
    func didTapName(in cell: MessageCollectionViewCell)
    
    func didTapAvatar(in cell: MessageCollectionViewCell)
    
    func didTapMessage(in cell: MessageCollectionViewCell)
    
}
