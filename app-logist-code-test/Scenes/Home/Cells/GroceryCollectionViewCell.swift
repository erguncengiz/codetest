//
//  GroceryCollectionViewCell.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 7.12.2022.
//

import UIKit
import SDWebImage

class GroceryCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "GroceryCollectionViewCell"
    
    // MARK: Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: Lifecycles
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func willDisplay(imageUrl: URL?, price: Float?, name: String?, currency: String?) {
        imageView.sd_setImage(with: imageUrl ?? URL(string: R.ImageURLS.getDefaultImage.getUrl()))
        nameLabel.text = name
        priceLabel.text = "\(price ?? 0.00) \(currency ?? "")"
    }
}
