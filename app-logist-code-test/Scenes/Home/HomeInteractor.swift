//
//  HomeInteractor.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 7.12.2022.

import UIKit
import Alamofire

protocol HomeBusinessLogic {
    func handle(request: Home.Grocery.Request)
}

class HomeInteractor: HomeBusinessLogic {
    var presenter: HomePresentationLogic?
    
    // MARK: Business Logic

    func handle(request: Home.Grocery.Request) {
        NetworkManager.shared.request(.get, url: R.Endpoints.getGroceries.getUrl(), requestModel: nil, model: [Home.Product].self) { response in
            switch(response)
            {
                case .success(let model):
                let response = Home.Grocery.Response(result: model as? [Home.Product])
                self.presenter?.present(response: response)
            
                case .failure(_): print("ERROR!")
            }
        }
        
    }
}
