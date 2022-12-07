//
//  HomeRouter.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 7.12.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeRoutingLogic {
    func routeToSomeWhere()
}

class HomeRouter: NSObject, HomeRoutingLogic {
    weak var viewController: HomeViewController?

    // MARK: Routing Logic
    
    func routeToSomeWhere() {
        
    }
}
