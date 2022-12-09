//
//  HomeRouter.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 7.12.2022.

import UIKit

protocol HomeRoutingLogic {
    func routeToBasket(vc: HomeViewController)
}

class HomeRouter: NSObject, HomeRoutingLogic {
    weak var viewController: HomeViewController?

    // MARK: Routing Logic
    
    func routeToBasket(vc: HomeViewController) {
        let flow: AppFlowProtocol? = viewController?.flow()
        flow?.route(to: .basket(vc), animated: true)
    }
}
