//
//  HomeInteractor.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 7.12.2022.

import UIKit
import Alamofire

protocol HomeBusinessLogic {
    func handle(request: Home.Grocery.Request)
    func setSelectedGrocery(index: Int, count: Int?, grocery: Home.Product?)
    func removeSelectedGrocery(index: Int)
    func getSelectedGroceries() -> [Basket.BasketGroceries.Groceries]
}

class HomeInteractor: HomeBusinessLogic {
    // MARK: Variables
    
    var presenter: HomePresentationLogic?
    var selectedGroceries: [Basket.BasketGroceries.Groceries] = []
    
    // MARK: Business Logic

    func handle(request: Home.Grocery.Request) {
        NetworkManager.shared.request(.get, url: R.Endpoints.getGroceries.getUrl(), requestModel: nil, model: [Home.Product].self) { response in
            switch(response)
            {
                case .success(let model):
                let response = Home.Grocery.Response(result: model as? [Home.Product])
                self.presenter?.present(response: response)
            
                case .failure(_): print("ERROR!")
            }
        }
    }
    
    func getSelectedGroceries() -> [Basket.BasketGroceries.Groceries] {
        return selectedGroceries
    }
    
    func calculateBasketGroceryCount() -> Int {
        var count = 0
        selectedGroceries.forEach { element in
            count += element.count
        }
        return count
    }
    
    func setSelectedGrocery(index: Int, count: Int?, grocery: Home.Product?) {
        for item in selectedGroceries {
            if grocery?.id == item.grocery.id {
                selectedGroceries.remove(at: index)
            }
        }

        selectedGroceries.append(Basket.BasketGroceries.Groceries(count: count ?? 0, grocery: grocery ?? Home.Product(id: "", name: "", price: 0.00, currency: "", imageUrl: "", stock: 0)))
        
        presenter?.sendCountOfBasket(count: calculateBasketGroceryCount())
    }
    
    func removeSelectedGrocery(index: Int) {
        selectedGroceries.remove(at: index)
        presenter?.sendCountOfBasket(count: calculateBasketGroceryCount())
    }
}
