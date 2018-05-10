//
//  MenuItemDetailViewController.swift
//  Restaurant
//
//  Created by M.D. Bijkerk on 09-05-18.
//  Copyright © 2018 M.D. Bijkerk. All rights reserved.
//

import UIKit

class MenuItemDetailViewController: UIViewController {
    
    
    var delegate: AddToOrderDelegate?
    
    // add a property to hold the menu item
    var menuItem: MenuItem!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addToOrderButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        setupDelegate()
    }
    
    func setupDelegate() {
        if let navController =
            tabBarController?.viewControllers?.last as?
            UINavigationController,
            let orderTableViewController =
            navController.viewControllers.first as?
            OrderTableViewController {
            delegate = orderTableViewController
        }
    }
    
    // specify what happens when the order button is tapped
    @IBAction func orderButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.addToOrderButton.transform =
                CGAffineTransform(scaleX: 3.0, y: 3.0)
            self.addToOrderButton.transform =
                CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        delegate?.added(menuItem: menuItem)
    }
    
    func updateUI() {
        titleLabel.text = menuItem.name
        priceLabel.text = String(format: "$%.2f", menuItem.price)
        descriptionLabel.text = menuItem.description
        addToOrderButton.layer.cornerRadius = 5.0
        
        // load images
        MenuController.shared.fetchImage(url: menuItem.imageURL) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
        
    }

}
