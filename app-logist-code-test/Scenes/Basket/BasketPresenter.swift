//
//  BasketPresenter.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 7.12.2022.

import UIKit

protocol BasketPresentationLogic {
    func present(response: Basket.BuyGroceries.Response)
    func present(message: String)
}

class BasketPresenter: BasketPresentationLogic {
    weak var viewController: BasketDisplayLogic?

    // MARK: Presentation Logic
    
    func present(response: Basket.BuyGroceries.Response) {
        let viewModel = Basket.BuyGroceries.ViewModel()
        viewController?.display(viewModel: viewModel)
    }
    
    func present(message: String) {
        viewController?.display(message: message)
    }
}
