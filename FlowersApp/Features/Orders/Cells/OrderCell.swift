//
//  OrderCell.swift
//  FlowersApp
//
//  Created by Emil Micu on 24/04/2018.
//  Copyright © 2018 Emil Micu. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var deliverToLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    func configureWith(order: Order) {
        deliverToLabel.text = "Deliver to: \(order.deliverTo ?? "unkown")"
        if let price = order.price {
            priceLabel.text = "Price: \(price)"
        } else {
            priceLabel.text = "unkown price"
        }
        
        descriptionLabel.text = order.description
    }
    
}
