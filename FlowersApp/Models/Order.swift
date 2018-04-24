//
//  Order.swift
//  FlowersApp
//
//  Created by Emil Micu on 24/04/2018.
//  Copyright © 2018 Emil Micu. All rights reserved.
//

import ObjectMapper
import Foundation


struct Order: Mappable {
    
    var ID: Int?
    var description: String?
    var price: Double?
    var deliverTo: String?
    
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    
    mutating func mapping(map: Map) {
        ID <- map["id"]
        description <- map["description"]
        price <- map["price"]
        deliverTo <- map["deliver_to"]
    }
}
