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

    
    public func buyGroceries(_ method: HTTPMethod, url: String, requestModel: Basket.BasketRequest?, model: Basket.BasketResponse.Type, errorModel: Basket.BasketErrorResponse.Type, completion: @escaping (AFResult<Codable>) -> Void) {

        AF.request(
            url,
            method: method,
            parameters: NetworkManager.toParameters(model: requestModel),
            encoding: JSONEncoding.default,
            headers: nil
        ).validate(statusCode: 200..<600).responseJSON { response in

            if case .success(let value) = response.result {
                    do {
                        let responseJsonData = JSON(value)
                        if response.response?.statusCode == 400 {
                            let responseModel = try JSONDecoder().decode(errorModel.self, from: responseJsonData.rawData())
                            print("Error!")
                            completion(.success(responseModel))
                        } else {
                            let responseModel = try JSONDecoder().decode(model.self, from: responseJsonData.rawData())
                            print("Success!")
                            completion(.success(responseModel))
                        }
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

    public func request<T:Codable> (_ method: HTTPMethod, url: String, requestModel: T?, model: T.Type, completion: @escaping (AFResult<Codable>) -> Void)
    {
        AF.request(
            url,
            method: method,
            parameters: NetworkManager.toParameters(model: requestModel),
            encoding: URLEncoding.default,
            headers: nil
        ).validate(statusCode: 200..<600).responseJSON{ response in

            if case .success(let value) = response.result {
                    do {
                        let responseJsonData = JSON(value)
                        print(responseJsonData)
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

    static func modelToJson<T:Encodable>(model:T) -> Data?
    {
        var jsonData: Data?
        
        do {
            jsonData = try JSONEncoder().encode(model)
            let jsonString = String(data: jsonData!, encoding: .utf8)!
        } catch { print(error) }
        
        return jsonData
    }

    static func jsonToParameters(from data: Data) -> [String: Any]?
    {
        return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    }
}
