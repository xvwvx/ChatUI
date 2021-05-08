//
//  ViewController.swift
//  ChatUI
//
//  Created by Snow on 2021/5/8.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    lazy var collectionView: MessagesCollectionView = {
        let collectionView = MessagesCollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "测试"
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        collectionView.register(MessageContentCell.self, forCellWithReuseIdentifier: "cell")
    }


}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let messagesFlowLayout = collectionViewLayout as? MessagesCollectionViewFlowLayout else { return .zero }
        return messagesFlowLayout.sizeForItem(at: indexPath)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let colors: [UIColor] = [.blue, .cyan, .green, .brown]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            as! MessageContentCell
        
        cell.contentView.backgroundColor = colors[(indexPath.row + 1) % colors.count]
        cell.avatarView.backgroundColor = colors[indexPath.row % colors.count]
        
        cell.nameLabel.font = UIFont.systemFont(ofSize: 10)
        cell.nameLabel.backgroundColor = .red
        cell.nameLabel.text = indexPath.description
        
        return cell
    }
}
