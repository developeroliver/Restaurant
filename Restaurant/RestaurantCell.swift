//
//  RestaurantCell.swift
//  Restaurant
//
//  Created by olivier geiger on 24/03/2024.
//

import UIKit

class RestaurantCell: UITableViewCell {
    
    static let reuseID  = "RestaurantCell"
    let restaurantName  = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupStyle()
        layout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: our style
    private func setupStyle() {
        restaurantName.translatesAutoresizingMaskIntoConstraints = false
        restaurantName.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    
    // MARK: our layout
    private func layout() {
        addSubview(restaurantName)
        
        NSLayoutConstraint.activate([
            restaurantName.leadingAnchor.constraint(equalToSystemSpacingAfter: imageView!.trailingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: restaurantName.trailingAnchor, multiplier: 2),
            restaurantName.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    
    // MARK: - Our logic
    func set(withName name: String, imageView: UIImageView) {
        restaurantName.text = name
        
        if let image = UIImage(named: name) {
            imageView.image = image
        } else {
            print("L'image avec le nom \(name) n'a pas pu être chargée.")
        }
    }
}






