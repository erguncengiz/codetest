//
//  BasketModels.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 7.12.2022.

import UIKit

enum Basket {
    
    enum BasketGroceries {
        struct Groceries {
            let count: Int
            let grocery: Home.Product
        }
    }
    
    enum Cell {
        case cell(model: BasketGroceries.Groceries)
        
        func identifier() -> String {
            switch self {
            case .cell:
                return BasketTableViewCell.identifier
            }
        }
    }
    
    // MARK: Use cases
    enum Something {
        struct Request {
        }
        struct Response {
        }
        struct ViewModel {
        }
    }
}
