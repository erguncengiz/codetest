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
    func removeSelectedGrocery(grocery: Home.Product?)
    func getSelectedGroceries() -> [Basket.BasketGroceries.Groceries]
    func calculateBasketGroceryCount() -> Int
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
        for grocery in selectedGroceries {
            if grocery.count == 0 {
                if let index = selectedGroceries.firstIndex(where: {$0 == grocery}) {
                    selectedGroceries.remove(at: index)
                }
            }
        }
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
        let indexOfGrocery = getCurrentIndex(grocery: grocery)

        for item in selectedGroceries {
            if grocery?.id == item.grocery.id {
                selectedGroceries.remove(at: indexOfGrocery ?? 0)
            }
        }

        selectedGroceries.append(Basket.BasketGroceries.Groceries(count: count ?? 0, grocery: grocery ?? Home.Product(id: "", name: "", price: 0.00, currency: "", imageUrl: "", stock: 0)))
        
        presenter?.sendCountOfBasket(count: calculateBasketGroceryCount())
    }
    
    func removeSelectedGrocery(grocery: Home.Product?) {
        let indexOfGrocery = getCurrentIndex(grocery: grocery)
        selectedGroceries.remove(at: indexOfGrocery!)
        presenter?.sendCountOfBasket(count: calculateBasketGroceryCount())
    }
    
    func getCurrentIndex(grocery: Home.Product?) -> Int? {
        var productList: [Home.Product] = []
        for item in selectedGroceries {
            productList.append(item.grocery)
        }
        let indexOfGrocery = productList.firstIndex(where: {$0 == grocery})
        return indexOfGrocery
    }
}
