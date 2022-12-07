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
        }
    }
}