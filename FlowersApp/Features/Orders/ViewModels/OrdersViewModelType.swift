//
//  OrdersViewModelType.swift
//  FlowersApp
//
//  Created by Emil Micu on 24/04/2018.
//  Copyright © 2018 Emil Micu. All rights reserved.
//

import Foundation
import Alamofire


protocol OrdersViewModelType: class {
    
    /// Number of orders fetched from server
    var numberOfOrders: Int { get }
    
    /// Get the order at specified position.
    /// - Parameter position: must be less than numberOfOrders and greater than -1
    func orderAt(position: Int) -> Order
    
    /// Retrieves the list of orders
    func getOrders(completion: ((Result<Void>) -> Void)?)
}
