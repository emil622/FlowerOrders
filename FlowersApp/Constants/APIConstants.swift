//
//  APIConstants.swift
//  FlowersApp
//
//  Created by Emil Micu on 24/04/2018.
//  Copyright © 2018 Emil Micu. All rights reserved.
//

import Foundation


/// Server API URLs
struct APIURLs {
    static let baseURLString = "https://demo0787159.mockable.io/"

    static let GetOrdersURL = URL(string: baseURLString + "user/orders")!
}
