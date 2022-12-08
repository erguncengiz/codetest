//
//  BasketViewControllerFactory.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 8.12.2022.
//

import UIKit

protocol BasketViewControllerFactoryProtocol {
    func makeBasket() -> UIViewController
}

extension ViewControllerFactory: BasketViewControllerFactoryProtocol {
    func makeBasket() -> UIViewController {
        let viewController = BasketViewController(nibName: "BasketView", bundle: nil)
        let interactor = BasketInteractor()
        let presenter = BasketPresenter()
        let router = BasketRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}
