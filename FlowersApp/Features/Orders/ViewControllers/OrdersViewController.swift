//
//  OrdersViewController.swift
//  FlowersApp
//
//  Created by Emil Micu on 24/04/2018.
//  Copyright © 2018 Emil Micu. All rights reserved.
//

import UIKit

final class OrdersViewController: UITableViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // MARK: - Properties
    var viewModel: OrdersViewModelType = OrdersViewModel()
    var detailViewController: OrderViewController? = nil
    private var isLoading = false

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl!)
        refreshControl?.addTarget(self, action: #selector(refreshOrders(_:)), for: .valueChanged)
        refreshControl?.tintColor = .blue
        tableView.register(UINib(nibName: "OrderCell", bundle: nil), forCellReuseIdentifier: "OrderCell")
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? OrderViewController
        }
        
        loadOrders()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        
        super.viewWillAppear(animated)
    }
    
    
    @objc private func refreshOrders(_ sender: Any) {
        loadOrders()
    }
    
    
    private func loadOrders() {
        isLoading = true
        
        if refreshControl?.isRefreshing == false {
            spinner.isHidden = false
            spinner.startAnimating()
        }
        viewModel.getOrders { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .failure(let error as AppError):
                self.presentError(error: error, completion: nil)
                
            case .success(_):
                self.tableView.reloadData()
                if self.viewModel.numberOfOrders == 0 {
                    self.title = "No Orders"
                } else {
                    self.title = "Orders"
                }
                
            default: break
            }
            
            self.refreshControl?.endRefreshing()
            self.isLoading = false
            self.spinner.stopAnimating()
        }
    }

    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let order = viewModel.orderAt(position: indexPath.row)
                let controller = (segue.destination as! UINavigationController).topViewController as! OrderViewController
                controller.order = order
                
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    
    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfOrders
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderCell
        let order = viewModel.orderAt(position: indexPath.row)
        
        cell.configureWith(order: order)
        
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: nil)
    }

}

