//
//  AppFlow.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 7.12.2022.
//

import Foundation

protocol AppFlowProtocol: FlowControllerProtocol {
    func route(to destination: Navigator.Destination, animated: Bool)
}

class AppFlow: NavigationFlowController, AppFlowProtocol {
    
    override init(dependency: DependencyFactoryProtocol) {
        super.init(dependency: dependency)
        route(to: .splash, animated: true)
    }
    
    required init(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    func route(to destination: Navigator.Destination, animated: Bool) {
        switch destination {
        case .splash:
            push(viewController: dependency.viewFactory.makeSplash(dependency: dependency), animated: animated)
        case .home(let sub):
            route(to: sub, animated: animated)
        case .basket(let vc):
            push(viewController: dependency.viewFactory.makeBasket(dependency: dependency, rootVC: vc), animated: animated)
        }
    }
    
    func route(to destination: Navigator.Destination.Home, animated: Bool) {
        let flow = HomeFlow(dependency: dependency)
        flow.route(to: destination, animated: false)
        push(viewController: flow, animated: animated)
    }
    
//    func route(to destination: Navigator.Destination.Basket, animated: Bool) {
//        let flow = BasketFlow(dependency: dependency)
//        flow.route(to: destination, animated: false)
//        push(viewController: flow, animated: animated)
//    }
}
