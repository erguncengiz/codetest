//
//  NavigatorFlowController.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 7.12.2022.
//

import UIKit

class NavigationFlowController: FlowController, UINavigationControllerDelegate {
    let navigation = UINavigationController()
    
    override init(dependency: DependencyFactoryProtocol) {
        super.init(dependency: dependency)
        add(child: navigation)
        // if unhide bar comment bottom line
        navigation.navigationBar.isHidden = true
        navigation.delegate = self
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func push(viewController: UIViewController, animated: Bool){
        if let previous = navigation.viewControllers.first(where: {
            controller in type(of: controller) == type(of: viewController)
        }) {
            navigation.popToViewController(previous, animated: animated)
        } else {
            if let flowing = viewController as? NavigationFlowController {
                navigation
                    .interactivePopGestureRecognizer?
                    .delegate = flowing.navigation
                    .interactivePopGestureRecognizer?
                    .delegate
            }
            navigation.pushViewController(viewController, animated: animated)
        }
    }
    
    func back(animated: Bool) {
        back(by: 1, animated: animated)
    }
    
    func back(by index: Int, animated: Bool) {
        let count = navigation.viewControllers.count
        
        for i in (count - index) ..< (count - 1) {
            let viewController = navigation.viewControllers.remove(at: i)
            viewController.removeFromParent()
        }
        
        if navigation.popViewController(animated: animated) == nil {
            back(by: index, animated: animated)
        }
    }
}
