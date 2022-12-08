//
//  FlowController.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 7.12.2022.
//

import UIKit

protocol FlowControllerProtocol: UIViewController {
    var dependency: DependencyFactoryProtocol { get }
}

class FlowController: UIViewController, FlowControllerProtocol {
    let dependency: DependencyFactoryProtocol
    
    init(dependency: DependencyFactoryProtocol) {
        self.dependency = dependency
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    func add(child: UIViewController) {
        child.willMove(toParent: self)
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
}

extension UIViewController {
    func flow<T>() -> T? {
        var viewController: UIViewController? = self
        
        while viewController != nil {
            if viewController is T {
                return viewController as? T
            }
            if viewController?.parent != nil {
                viewController = viewController?.parent
            } else if viewController?.presentingViewController != nil {
                viewController = viewController?.presentingViewController
            } else {
                viewController = nil
            }
        }
        
        return nil
    }
}
