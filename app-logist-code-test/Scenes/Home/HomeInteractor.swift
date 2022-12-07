//
//  HomeInteractor.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 7.12.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeBusinessLogic {
    func handle(request: Home.Something.Request)
}

class HomeInteractor: HomeBusinessLogic {
    var presenter: HomePresentationLogic?
    
    // MARK: Business Logic

    func handle(request: Home.Something.Request) {
        let response = Home.Something.Response()
        presenter?.present(response: response)
    }
}
