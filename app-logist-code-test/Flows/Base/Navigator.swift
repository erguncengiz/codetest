//
//  Navigator.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 7.12.2022.
//

protocol NavigatorProtocol {
    func to(_ destination: Navigator.Destination, animated: Bool)
}

class Navigator: NavigatorProtocol {
    enum Destination {
        enum Home {
            case home
        }
        
        enum Basket {
            case home
        }
        
        case home(Home)
        case basket(HomeViewController)
        case splash
    }
    
    static let shared = Navigator()
    private init(){}
    
    var flow: AppFlowProtocol?
    
    func to(_ destination: Destination, animated: Bool) {
        flow?.route(to: destination, animated: animated)
    }
}
