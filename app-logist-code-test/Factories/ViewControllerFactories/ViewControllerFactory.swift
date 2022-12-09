//
//  ViewControllerFactory.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 7.12.2022.
//

import UIKit

protocol ViewControllerFactoryProtocol: HomeViewControllerFactoryProtocol, BasketViewControllerFactoryProtocol {
    func makeSplash(dependency: DependencyFactoryProtocol) -> UIViewController
    func makeBasket(dependency: DependencyFactoryProtocol, rootVC: HomeViewController) -> UIViewController
}

struct ViewControllerFactory: ViewControllerFactoryProtocol {
    
    static let shared = ViewControllerFactory()
    private init(){}
    
    func makeSplash(dependency: DependencyFactoryProtocol) -> UIViewController {
        let viewController = SplashViewController(nibName: "SplashViewController", bundle: nil)
        //set viewController values
        return viewController
    }
    
    func makeBasket(dependency: DependencyFactoryProtocol, rootVC: HomeViewController) -> UIViewController {
        let viewController = BasketViewController(nibName: "BasketView", bundle: nil)
        //set viewController values
        let presenter = BasketPresenter()
        let router = BasketRouter()
        let interactor = BasketInteractor()
        router.viewController = viewController
        presenter.viewController = viewController
        interactor.presenter = presenter
        viewController.router = router
        viewController.rootVC = rootVC
        viewController.interactor = interactor
        return viewController
    }
    
}
