//
//  SplashViewController.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 7.12.2022.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
    }
    
    // Starting splash screen
    
    private func routeToHome() {
        let flow: AppFlowProtocol? = self.flow()
        flow?.route(to: .home(.home), animated: true)
    }
    
    private func load() {
        guard let flow: FlowControllerProtocol = self.flow() else { preconditionFailure("Flow not reachable") }
        
        guard let _: AppFlowProtocol = flow.flow() else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            [weak self] in
            self?.routeToHome()
        }
    }
}
