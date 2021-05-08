//
//  CellSizeCalculator.swift
//  ChatUI
//
//  Created by Snow on 2021/5/8.
//

import UIKit

open class CellSizeCalculator {
    
    public weak var layout: UICollectionViewFlowLayout?
    
    open func configure(attributes: UICollectionViewLayoutAttributes) {}
    
    open func sizeForItem(at indexPath: IndexPath) -> CGSize { return .zero }
    
    public init() {}

}
