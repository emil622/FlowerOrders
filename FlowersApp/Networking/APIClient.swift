//
//  APIClient.swift
//  FlowersApp
//
//  Created by Emil Micu on 24/04/2018.
//  Copyright © 2018 Emil Micu. All rights reserved.
//

import ObjectMapper
import Foundation
import Alamofire

final class APIClient {
    
    /// The method used to make every request to the server. This method parses the result and detects general errors in response.
    /// If any error is found will be further passed. If no error is detected will pass a succes message with the returned content.
    /// The content will pe parsed by the receiver (next layer). This is the base layer for all API requests.
    static func makeAPIRequest(URL: URL,
                               params: [String: AnyObject]?,
                               method: HTTPMethod,
                               completion: @escaping (Result<[[String: Any]]>) -> Void) {
        
        let defaultHeader = ["Content-Type": "application/json"]
        print("URL: \(URL) \nParameters: \(String(describing: params))")
        
        Alamofire.request(URL, method: method, parameters: params, encoding: URLEncoding.httpBody, headers: defaultHeader).responseJSON(completionHandler: { (responseObject) -> Void in
            
            print("JSON \(responseObject)")
            
            switch responseObject.result {
            case let .success(json as [[String: Any]]):
                completion(.success(json))
                
            case let .failure(error):
                completion(.failure(AppError(title: "Error", message: error.localizedDescription)))
                
            default:
                completion(.failure(AppError()))
            }
        })
    }
    
    
    /// Extracts an array of the given type. The type is infered from the return type which sould be an array of Mappable objects
    static func extractArrayFromJson<T>(json: [[String: Any]]) throws -> [T] where T: Mappable {
        // If there is an array, try to create objects of the given type and add the to the typed array
        var dataArray = [T]()
        for itemJson in json {
            let map = Map(mappingType: .fromJSON, JSON: itemJson)
            
            guard let item = T(map: map) else {
                // Could not create object of the given type with the current data, move on to the next one
                continue
            }
            dataArray.append(item)
        }
        
        return dataArray
    }
}
