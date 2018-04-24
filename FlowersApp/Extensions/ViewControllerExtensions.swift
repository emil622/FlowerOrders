//
//  ViewControllerExtensions.swift
//  FlowersApp
//
//  Created by Emil Micu on 24/04/2018.
//  Copyright © 2018 Emil Micu. All rights reserved.
//

import UIKit


/// ErrorPresenter
/// To be set to the classes that need to get an popover alert.
protocol ErrorPresenter {
    func presentError(error: AppError, completion: (() -> Void)?)
}

/// Every view controller that conforms to this protocol will get this method that presents a AppError
extension ErrorPresenter where Self: UIViewController {
    
    // Present a DError
    func presentError(error: AppError = AppError(), completion: (() -> Void)?) {
        let alertController = UIAlertController(title: error.title,
                                                message: error.message,
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK",
                                                style: .cancel,
                                                handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
}

/// Make all view controllers error presenters. This will add the error presenting method on all view controllers by default
extension UIViewController: ErrorPresenter { }
