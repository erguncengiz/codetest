//
//  BasketInteractor.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 7.12.2022.

import UIKit

protocol BasketBusinessLogic {
    func handle(request: Basket.Something.Request)
}

class BasketInteractor: BasketBusinessLogic {
    var presenter: BasketPresentationLogic?
    
    // MARK: Business Logic

    func handle(request: Basket.Something.Request) {
        let response = Basket.Something.Response()
        presenter?.present(response: response)
    }
}
