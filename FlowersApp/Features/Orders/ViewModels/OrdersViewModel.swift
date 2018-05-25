//
//  OrdersViewModel.swift
//  FlowersApp
//
//  Created by Emil Micu on 24/04/2018.
//  Copyright © 2018 Emil Micu. All rights reserved.
//

import Foundation
import Alamofire


final class OrdersViewModel: OrdersViewModelType {
    
    var numberOfOrders: Int {
        return orders.count
    }
    fileprivate var orders = [Order]()
    

    func orderAt(position: Int) -> Order {
        return orders[position]
    }
    
    
    func getOrders(completion: ((Result<Void>) -> Void)?) {
        APIClient.makeAPIRequest(URL: APIURLs.GetOrdersURL, params: nil, method: .get) { (result) in
            switch result {
            case .failure(let error as AppError):
                completion?(.failure(error))
                
            case.success(let json):
                do {
                    self.orders = try APIClient.extractArrayFromJson(json: json)
                    completion?(.success(()))
                } catch {
                    completion?(.failure(AppError(title: "Error", message: "Unkown data")))
                }
            default: break
            }
        }
    }
}
