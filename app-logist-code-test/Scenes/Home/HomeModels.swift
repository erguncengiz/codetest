//
//  HomeModels.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 7.12.2022.

import UIKit

enum Home {
    
    struct Product: Codable {
        let id: String?
        let name: String?
        let price: Float?
        let currency: String?
        let imageUrl: String?
        let stock: Int?
    }
    
    enum Cell {
        case cell(model: Product)
        
        func identifier() -> String {
            switch self {
            case .cell:
                return GroceryCollectionViewCell.identifier
            }
        }
    }
    
    // MARK: Use cases
    enum Grocery {
        struct Request {
        }
        struct Response: Codable {
            let result: [Product]?
        }
        struct ViewModel {
            let result: [Cell]?
        }
    }
}
