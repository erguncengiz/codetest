//
//  HomePresenter.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 7.12.2022.

import UIKit

protocol HomePresentationLogic {
    func present(response: Home.Grocery.Response)
    func sendCountOfBasket(count: Int)
}

class HomePresenter: HomePresentationLogic {
    
    weak var viewController: HomeDisplayLogic?
    
    // MARK: Presentation Logic
    
    func present(response: Home.Grocery.Response) {
        viewController?.display(viewModel: Home.Grocery.ViewModel(result: getCells(entity: response.result ?? [])))
        viewController?.didReceiveData()
    }
    
    func getCells(entity: [Home.Product]) -> [Home.Cell] {
        var cells = [Home.Cell]()
        for item in entity {
            cells.append(.cell(model: Home.Product(
                id: item.id ?? "",
                name: item.name ?? "",
                price: item.price ?? 0.00,
                currency: item.currency ?? "",
                imageUrl: item.imageUrl ?? "",
                stock: item.stock ?? 0))
            )
        }
        return cells
    }
    
    func sendCountOfBasket(count: Int) {
        viewController?.setCurrentBasketCount(count: count)
    }
}
