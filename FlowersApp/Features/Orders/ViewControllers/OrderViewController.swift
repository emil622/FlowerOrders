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
    @IBOutlet weak var detailDescriptionLabel: UILabel!

    // MARK: - Properties
    var detailItem: NSDate? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }


    // MARK: - View Setup
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }
}

