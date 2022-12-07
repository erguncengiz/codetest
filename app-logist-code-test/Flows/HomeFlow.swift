//
//  HomeFlow.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 7.12.2022.
//

protocol HomeFlowProtocol: FlowControllerProtocol {
    func route(to destination: Navigator.Destination.Home, animated: Bool)
}

class HomeFlow: NavigationFlowController, HomeFlowProtocol {
    func route(to destination: Navigator.Destination.Home, animated: Bool) {
        switch destination {
        case .home:
            push(viewController: dependency.viewFactory.makeHome(), animated: animated)
        }
    }
}
