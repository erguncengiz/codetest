//
//  UICollectionViewCell.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 7.12.2022.
//

import UIKit

extension UICollectionViewCell {
    static func identifier() -> String {
        String(describing: self)
    }
    
    static func registerWithNib(to collectionView: UICollectionView?) {
        collectionView?.register(UINib(nibName: identifier(), bundle: nil), forCellWithReuseIdentifier: identifier())
    }
}
