//
//  BasketRouter.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 7.12.2022.

import UIKit

protocol BasketRoutingLogic {
    func routeToBack()
}

class BasketRouter: NSObject, BasketRoutingLogic {
    weak var viewController: BasketViewController?
    
    // MARK: Routing Logic
    
    func routeToBack() {
       //
    }
}
