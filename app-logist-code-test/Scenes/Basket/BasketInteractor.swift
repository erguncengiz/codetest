//
//  BasketInteractor.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 7.12.2022.

import UIKit
import Alamofire
import SwiftyJSON

protocol BasketBusinessLogic {
    func handle(request: Basket.BuyGroceries.Request)
    func fillGroceries(rootVC: HomeViewController?)
    func setNewValues(index: Int, grocery: Basket.BasketGroceries.Groceries)
    func removeItemFromGroceries(index: Int)
    func removeAll()
    func getGroceries() -> [Basket.BasketGroceries.Groceries]
    func fetchRootCells(rootVC: HomeViewController?)
    func buyGroceries()
}

class BasketInteractor: BasketBusinessLogic {
    var presenter: BasketPresentationLogic?
    var groceries: [Basket.BasketGroceries.Groceries] = []
    var message: String = ""
    
    // MARK: Business Logic
    
    func handle(request: Basket.BuyGroceries.Request) {
        let response = Basket.BuyGroceries.Response()
        presenter?.present(response: response)
    }
    
    func fillGroceries(rootVC: HomeViewController?) {
        groceries = rootVC?.interactor?.getSelectedGroceries() ?? []
    }
    
    func setNewValues(index: Int, grocery: Basket.BasketGroceries.Groceries) {
        groceries.remove(at: index)
        groceries.insert(grocery, at: index)
    }
    
    func removeItemFromGroceries(index: Int) {
        groceries.remove(at: index)
    }
    
    func removeAll() {
        groceries.removeAll()
    }
    
    func getGroceries() -> [Basket.BasketGroceries.Groceries] {
        return groceries
    }
    
    func fetchRootCells(rootVC: HomeViewController?) {
        if groceries.count < 1 {
            rootVC?.makeZeroAllCells()
        } else {
            for item in groceries {
                for element in (rootVC?.interactor?.getSelectedGroceries() ?? []) {
                    if item.grocery.id == element.grocery.id {
                        rootVC?.resetCells(count: item.count, id: item.grocery.id!)
                    }
                }
            }
        }
    }
    
    func buyGroceries() {
        var request: Basket.BasketRequest
        var requestList: [Basket.Product] = []
        for item in groceries {
            let request = Basket.Product(id: item.grocery.id ?? "", amount: item.count)
            requestList.append(request)
        }
        request = Basket.BasketRequest(products: requestList)
        
        NetworkManager.shared.buyGroceries(.post, url: R.Endpoints.checkoutGroceries.getUrl(), requestModel: request, model: Basket.BasketResponse.self, errorModel: Basket.BasketErrorResponse.self) { response in
            switch(response)
            {
            case .success(let model):
                self.message = (model as? Basket.BasketResponse)?.message ?? "-"
                self.presenter?.present(message: self.message)
            case .failure(_):
                self.message = "Hata! Satın alma gerçekleşmedi"
                self.presenter?.present(message: self.message)
            }
        }
    }
}
