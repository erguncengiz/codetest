//
//  BasketTableViewCell.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 8.12.2022.
//

import UIKit

class BasketTableViewCell: UITableViewCell {
    
    // MARK: Variables
    
    static let identifier: String = "BasketTableViewCell"
    var currentCount: Int = 0
    var viewController: BasketViewController?
    var rootVC: HomeViewController?
    var currentModel: Basket.BasketGroceries.Groceries?
    var modelIndex: Int?
    
    // MARK: Outlets
    
    @IBOutlet weak var groceryImage: UIImageView!
    @IBOutlet weak var groceryNameLabel: UILabel!
    @IBOutlet weak var groceryPriceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func willDisplay(model: Basket.BasketGroceries.Groceries?, viewController: BasketViewController?, index: Int, rootVC: HomeViewController?) {
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        groceryImage.sd_setImage(with: URL(string: model?.grocery.imageUrl ?? ""))
        groceryNameLabel.text = model?.grocery.name
        groceryPriceLabel.text = "\(model?.grocery.price ?? 0.00) \(model?.grocery.currency ?? "")"
        countLabel.text = "\(model?.count ?? 0)"
        currentCount = model?.count ?? 0
        currentModel = model
        modelIndex = index
        self.rootVC = rootVC
        self.viewController = viewController
    }

    @IBAction func plusClicked(_ sender: Any) {
        if currentCount < (currentModel?.grocery.stock ?? 7) {
            currentCount += 1
            let model = Basket.BasketGroceries.Groceries(count: currentCount, grocery: currentModel!.grocery)
            viewController?.setNewValues(grocery: model, index: modelIndex!)
        }
        
    }
    
    @IBAction func minusClicked(_ sender: Any) {
        if currentCount > 1 {
            currentCount -= 1
            let model = Basket.BasketGroceries.Groceries(count: currentCount, grocery: currentModel!.grocery)
            viewController?.setNewValues(grocery: model, index: modelIndex!)
        } else {
            viewController?.removeItemFromGroceries(index: modelIndex!)
            rootVC?.removeSelectedGrocery(grocery: currentModel?.grocery)
        }
        
    }
}
