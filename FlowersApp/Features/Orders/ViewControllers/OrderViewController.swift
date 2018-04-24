//
//  DetailViewController.swift
//  FlowersApp
//
//  Created by Emil Micu on 24/04/2018.
//  Copyright © 2018 Emil Micu. All rights reserved.
//

import UIKit

final class OrderViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var deliverToLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionContentLabel: UILabel!
    
    // MARK: - Properties
    var order: Order?
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }


    // MARK: - View Setup
    func configureView() {
        // Update the user interface for the detail item.
        if let order = order {
            if let ID = order.ID {
                idLabel.text = "Order ID: \(ID)"
            } else {
                idLabel.text = "unkown ID"
            }
            
            if let price = order.price {
                priceLabel.text = "Price: \(price)"
            } else {
                priceLabel.text = "unkown price"
            }

            deliverToLabel.text = "Deliver To: \(order.deliverTo ?? "unkown")"
            descriptionContentLabel.text = order.description
        }
    }
}

