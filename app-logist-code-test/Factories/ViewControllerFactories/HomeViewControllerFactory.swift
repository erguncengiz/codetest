//
//  HomeViewControllerFactory.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 7.12.2022.
//

import UIKit

protocol HomeViewControllerFactoryProtocol {
    func makeHome() -> UIViewController
}

extension ViewControllerFactory: HomeViewControllerFactoryProtocol {
    func makeHome() -> UIViewController {
        let viewController = HomeViewController(nibName: "HomeView", bundle: nil)
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}
