//
//  BasketModels.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 7.12.2022.

import UIKit

enum Basket {
    
    enum BasketGroceries {
        struct Groceries: Equatable {
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
    enum BuyGroceries {
        struct Request {
        }
        struct Response {
        }
        struct ViewModel {
        }
    }
    
    // MARK: - BasketResponse
    struct BasketResponse: Codable {
        let orderID, message: String
    }
    
    // MARK: - BasketResponse
    struct BasketErrorResponse: Codable {
        let error: String
    }
    
    // MARK: - BasketRequest
    struct BasketRequest: Codable {
        let products: [Product]
    }

    // MARK: - Product
    struct Product: Codable {
        let id: String
        let amount: Int
    }
}


