//
//  AppError.swift
//  FlowersApp
//
//  Created by Emil Micu on 24/04/2018.
//  Copyright © 2018 Emil Micu. All rights reserved.
//

import Foundation


struct AppError: Error {
    var title: String
    var message: String
    
    init(title: String = "Oops",
         message: String = "Something went wrong, please try again later.") {
        
        self.title = title
        self.message = message
    }
}
