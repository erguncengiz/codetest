//
//  BasketViewController.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 7.12.2022.

import UIKit

protocol BasketDisplayLogic: AnyObject {
    func display(viewModel: Basket.Something.ViewModel)
}

class BasketViewController: UIViewController, BasketDisplayLogic {
    var rootVC: HomeViewController?
    var interactor: BasketBusinessLogic?
    var router: (NSObjectProtocol & BasketRoutingLogic)?
    var groceries: [Basket.BasketGroceries.Groceries]? = []

    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        let request = Basket.Something.Request()
        interactor?.handle(request: request)
        groceries = rootVC?.interactor?.getSelectedGroceries()
        print(groceries?.count ?? 0)
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        BasketTableViewCell.registerWithNib(to: tableView)
    }

    // MARK: Requests

    func display(viewModel: Basket.Something.ViewModel) {
    
    }
}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketTableViewCell", for: indexPath) as? BasketTableViewCell
        cell?.willDisplay(model: groceries?[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    
}
