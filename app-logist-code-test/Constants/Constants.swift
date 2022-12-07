//
//  Constants.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 7.12.2022.
//

import Foundation

struct R {
    enum Endpoints {
        case getGroceries
        case checkoutGroceries
        
        func getUrl() -> String {
            switch self {
            case .getGroceries:
                return "https://desolate-shelf-18786.herokuapp.com/list"
            case .checkoutGroceries:
                return "https://desolate-shelf-18786.herokuapp.com/checkout"
            }
        }
    }
    
    enum ImageURLS {
        case getDefaultImage
        
        func getUrl() -> String {
            switch self {
            case .getDefaultImage:
                return "https://waterstation.com.tr/img/default.jpg"
            }
        }
    }
    
    
}
