//
//  BasketPresenter.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 7.12.2022.

import UIKit

protocol BasketPresentationLogic {
    func present(response: Basket.Something.Response)
}

class BasketPresenter: BasketPresentationLogic {
    weak var viewController: BasketDisplayLogic?

    // MARK: Presentation Logic
    
    func present(response: Basket.Something.Response) {
        let viewModel = Basket.Something.ViewModel()
        viewController?.display(viewModel: viewModel)
    }
}
