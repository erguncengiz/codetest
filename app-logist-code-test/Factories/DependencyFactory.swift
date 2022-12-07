//
//  DependencyFactories.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 7.12.2022.
//

import Foundation

protocol DependencyFactoryProtocol {
    //
    var viewFactory: ViewControllerFactoryProtocol { get }
}

struct DependencyFactory: DependencyFactoryProtocol {
    var viewFactory: ViewControllerFactoryProtocol {
        ViewControllerFactory.shared
    }
}
