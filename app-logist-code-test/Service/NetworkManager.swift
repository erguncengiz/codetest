//
//  NetworkManager.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 7.12.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    
    static let shared = NetworkManager()
    private init(){}

    let headers : HTTPHeaders = [
        "Accept": "*/*",
        "User-Agent": "Mozilla/5.0 (compatible; Rigor/1.0.0; http://rigor.com)"
    ]


    public func request<T:Codable> (_ method: HTTPMethod, url: String, requestModel: T?, model: T.Type, completion: @escaping (AFResult<Codable>) -> Void)
    {
        AF.request(
            url,
            method: method,
            parameters: NetworkManager.toParameters(model: requestModel),
            encoding: URLEncoding.default,
            headers: headers
        ).validate(statusCode: 200..<600).responseJSON{ response in

            if case .success(let value) = response.result {
                    do {
                        let responseJsonData = JSON(value)
                        let responseModel = try JSONDecoder().decode(model.self, from: responseJsonData.rawData())
                        print("Success!")
                        completion(.success(responseModel))
                    }
                    catch let parsingError {
                        print("Success (error): \(parsingError)")
                    }
            } else if case .failure(let error) = response.result {
                print("Failure: \(error)")
                completion(.failure(error))
            }
        }
    }

    static func toParameters<T:Encodable>(model: T?) -> [String:AnyObject]?
    {
        if(model == nil)
        {
            return nil
        }
        
        let jsonData = modelToJson(model:model)
        let parameters = jsonToParameters(from: jsonData!)
        return parameters! as [String: AnyObject]
    }

    static func modelToJson<T:Encodable>(model:T)  -> Data?
    {
        return try! JSONEncoder().encode(model.self)
    }

    static func jsonToParameters(from data: Data) -> [String: Any]?
    {
        return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    }
}
