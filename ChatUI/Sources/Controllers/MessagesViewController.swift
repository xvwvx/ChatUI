//
//  MessagesViewController.swift
//  ChatUI
//
//  Created by Snow on 2021/5/8.
//

import UIKit

class MessagesViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIGestureRecognizerDelegate {
    
    open var messagesCollectionView = MessagesCollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Methods [Private]

    private func setupDefaults() {
        extendedLayoutIncludesOpaqueBars = true
        view.backgroundColor = .white
        messagesCollectionView.keyboardDismissMode = .interactive
        messagesCollectionView.alwaysBounceVertical = true
        messagesCollectionView.backgroundColor = .white
        if #available(iOS 13.0, *) {
            messagesCollectionView.automaticallyAdjustsScrollIndicatorInsets = false
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let messagesFlowLayout = collectionViewLayout as? MessagesCollectionViewFlowLayout else { return .zero }
        return messagesFlowLayout.sizeForItem(at: indexPath)
    }

    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

        guard let messagesCollectionView = collectionView as? MessagesCollectionView else {
            fatalError()
        }
        guard let layoutDelegate = messagesCollectionView.messagesLayoutDelegate else {
            fatalError()
        }
        
        return layoutDelegate.headerViewSize(for: section, in: messagesCollectionView)
    }
    
    open func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // MARK: - UICollectionViewDataSource
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let collectionView = collectionView as? MessagesCollectionView else {
            fatalError()
        }
        let sections = collectionView.messagesDataSource?.numberOfSections(in: collectionView) ?? 0
        return sections
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let collectionView = collectionView as? MessagesCollectionView else {
            fatalError()
        }
        return collectionView.messagesDataSource?.numberOfItems(inSection: section, in: collectionView) ?? 0
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let messagesCollectionView = collectionView as? MessagesCollectionView else {
            fatalError()
        }

        guard let messagesDataSource = messagesCollectionView.messagesDataSource else {
            fatalError()
        }

        let message = messagesDataSource.messageForItem(at: indexPath, in: messagesCollectionView)

        switch message.kind {
        case .text, .attributedText:
            let cell = messagesCollectionView.dequeueReusableCell(TextMessageCell.self, for: indexPath)
            cell.configure(with: message, at: indexPath, and: messagesCollectionView)
            return cell
        }
    }
    
    // MARK: - UIGestureRecognizerDelegate
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let panGesture = gestureRecognizer as? UIPanGestureRecognizer else {
            return false
        }
        let velocity = panGesture.velocity(in: messagesCollectionView)
        return abs(velocity.x) > abs(velocity.y)
    }
}
