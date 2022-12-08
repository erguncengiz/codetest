//
//  BasketFlow.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 8.12.2022.
//

protocol BasketFlowProtocol: FlowControllerProtocol {
    func route(to destination: Navigator.Destination.Basket, animated: Bool)
}

class BasketFlow: NavigationFlowController, BasketFlowProtocol {
    func route(to destination: Navigator.Destination.Basket, animated: Bool) {
        switch destination {
        case .home:
            push(viewController: dependency.viewFactory.makeBasket(), animated: animated)
        }
    }
}
