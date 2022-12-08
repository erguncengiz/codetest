//
//  BasketTableViewCell.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 8.12.2022.
//

import UIKit

class BasketTableViewCell: UITableViewCell {
    
    static let identifier: String = "BasketTableViewCell"
    
    // MARK: Outlets
    
    @IBOutlet weak var groceryImage: UIImageView!
    @IBOutlet weak var groceryNameLabel: UILabel!
    @IBOutlet weak var groceryPriceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func willDisplay(model: Basket.BasketGroceries.Groceries?) {
        groceryImage.sd_setImage(with: URL(string: model?.grocery.imageUrl ?? ""))
        groceryNameLabel.text = model?.grocery.name
        groceryPriceLabel.text = "\(model?.grocery.price ?? 0.00) \(model?.grocery.currency ?? "")"
        countLabel.text = "\(model?.count ?? 0)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
