//
//  BasketViewController.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 7.12.2022.

import UIKit

protocol BasketDisplayLogic: AnyObject {
    func display(viewModel: Basket.BuyGroceries.ViewModel)
    func display(message: String)
    func setNewValues(grocery: Basket.BasketGroceries.Groceries, index: Int)
    func removeItemFromGroceries(index: Int)
}

class BasketViewController: UIViewController, BasketDisplayLogic {
    
    
    var rootVC: HomeViewController?
    var interactor: BasketBusinessLogic?
    var router: (NSObjectProtocol & BasketRoutingLogic)?
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        let request = Basket.BuyGroceries.Request()
        interactor?.handle(request: request)
        interactor?.fillGroceries(rootVC: rootVC)
        configureLabel()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        BasketTableViewCell.registerWithNib(to: tableView)
    }
    
    func configureLabel() {
        var totalPrice: Float = 0.0
        let groceries = interactor?.getGroceries()
        groceries?.forEach({ element in
            totalPrice += Float(element.count) * (element.grocery.price ?? 0.0)
        })
        totalPriceLabel.text = "\(String(format: "%.2f", totalPrice)) ₺"
    }
    
    func setNewValues(grocery: Basket.BasketGroceries.Groceries, index: Int) {
        interactor?.setNewValues(index: index, grocery: grocery)
        configureLabel()
        tableView.reloadData()
    }
    
    @IBAction func deleteClicked(_ sender: Any) {
        showDeleteAlert()
    }
    
    @IBAction func closeClicked(_ sender: Any) {
        fetchRootCells()
        rootVC?.setCurrentBasketCount()
        self.navigationController?.popViewController(animated: true)
    }
    
    func fetchRootCells() {
        interactor?.fetchRootCells(rootVC: rootVC)
    }
    
    func removeItemFromGroceries(index: Int) {
        interactor?.removeItemFromGroceries(index: index)
        configureLabel()
        tableView.reloadData()
    }
    
    func showDeleteAlert() {
        let alert = UIAlertController(title: "Uyarı", message: "Bütün sepetinizi boşaltmak istiyor musunuz?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "İptal", style: .cancel, handler: { action in
            switch action.style {
            case .cancel:
                print("Cancel")
                
            default:
                break
            }
        }))
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { action in
            switch action.style {
            case .default:
                self.interactor?.removeAll()
                self.configureLabel()
                self.tableView.reloadData()
            default:
                break
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showTransactionAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { action in
            switch action.style {
            case .default:
                self.interactor?.removeAll()
                self.configureLabel()
                self.tableView.reloadData()
            default:
                break
            }
        }))
    
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func approveBasketClicked(_ sender: Any) {
        interactor?.buyGroceries()
    }
    // MARK: Requests
    
    func display(viewModel: Basket.BuyGroceries.ViewModel) {
        //
    }
    
    func display(message: String) {
        showTransactionAlert(message: message)
    }
}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let groceries = interactor?.getGroceries()
        return groceries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let groceries = interactor?.getGroceries()
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketTableViewCell", for: indexPath) as? BasketTableViewCell
        cell?.willDisplay(model: groceries?[indexPath.row], viewController: self, index: indexPath.row, rootVC: rootVC)
        return cell ?? UITableViewCell()
    }
    
    
}
