//
//  GroceryCollectionViewCell.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 7.12.2022.
//

import UIKit
import SDWebImage

class GroceryCollectionViewCell: UICollectionViewCell {
    
    // MARK: Variables
    
    static let identifier: String = "GroceryCollectionViewCell"
    var currentStock = 0
    var currentIndex = 0
    var addedStock = 0
    var minusIsHidden = true
    var selectedProducts: [Home.Product] = []
    var currentModel: Home.Product?
    var viewController: HomeViewController?
    
    // MARK: Outlets
    
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var shoppingView: UIView!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: Lifecycles
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.counterLabel.isHidden = minusIsHidden
        self.minusButton.isHidden = minusIsHidden
    }
    
    func willDisplay(model: Home.Product, index: Int, viewController: HomeViewController) {
        self.layer.cornerRadius = 8
        self.viewController = viewController
        currentModel = model
        imageView.sd_setImage(with: URL(string: model.imageUrl ?? ""))
        nameLabel.text = model.name
        priceLabel.text = "\(model.price ?? 0.00) \(model.currency ?? "")"
        currentStock = model.stock ?? 0
        currentIndex = index
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        minusButton.isHidden = minusIsHidden
        counterLabel.isHidden = minusIsHidden
        layer.cornerRadius = 8
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 8)
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5);
        layer.shadowOpacity = 0.5
        layer.shadowPath = shadowPath.cgPath
        layer.shadowRadius = 5
    }
    
    @IBAction func plusClicked(_ sender: Any){
        minusIsHidden = false
        if addedStock < currentStock  {
            addedStock += 1
            viewController?.setSelectedGrocery(index: currentIndex, count: addedStock, grocery: currentModel)
        }
        counterLabel.text = "\(addedStock)"
    }
    
    @IBAction func minusClicked(_ sender: Any){
        if addedStock > 0  {
            addedStock -= 1
            viewController?.setSelectedGrocery(index: currentIndex, count: addedStock, grocery: currentModel)
            if addedStock == 0 {
                minusIsHidden = true
                viewController?.removeSelectedGrocery(index: currentIndex)
            }
        }
        counterLabel.text = "\(addedStock)"
    }
}
