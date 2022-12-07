//
//  ViewControllerFactory.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 7.12.2022.
//

import Foundation
import UIKit

protocol ViewControllerFactoryProtocol {
    func makeSplash(dependency: DependencyFactoryProtocol) -> UIViewController
}

struct ViewControllerFactory: ViewControllerFactoryProtocol {
    
    static let shared = ViewControllerFactory()
    private init(){}
    
    func makeSplash(dependency: DependencyFactoryProtocol) -> UIViewController {
        return UIViewController()
    }
}
