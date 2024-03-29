//
//  RestaurantCell.swift
//  Restaurant
//
//  Created by olivier geiger on 24/03/2024.
//

import UIKit

class RestaurantCell: UITableViewCell {
    
    static let reuseID      = "RestaurantCell"
    
    let thumbnailImageView  = UIImageView()
    let stackView           = UIStackView()
    let nameLabel           = UILabel()
    let locationLabel       = UILabel()
    let typeLabel           = UILabel()
    let favoriteImageView   = UIImageView()
    let sharedButton        = UIButton(type: .system)
    
    // MARK: -  LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStyle()
        layout()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.tintColor = .systemYellow
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Our Style and Layout
extension RestaurantCell {
    
    private func setupStyle() {
        /// thumbnailImageView
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.contentMode          = .scaleAspectFit
        thumbnailImageView.layer.cornerRadius   = 20
        thumbnailImageView.layer.masksToBounds  = true
        
        /// stackView
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis          = .vertical
        stackView.distribution  = .fill
        stackView.alignment     = .top
        stackView.spacing       = 4
        
        /// nameLabel
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        
        /// locationLabel
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
        /// typeLabel
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.textColor     = UIColor.secondaryLabel
        typeLabel.font          = UIFont.preferredFont(forTextStyle: .subheadline)
        
        /// favortieImageView
        favoriteImageView.translatesAutoresizingMaskIntoConstraints = false
        favoriteImageView.image = UIImage(systemName: "heart.fill")
        favoriteImageView.tintColor = .systemYellow
        
        /// sharedButton
        sharedButton.translatesAutoresizingMaskIntoConstraints = false
        sharedButton.setImage(UIImage(named: "share"), for: .normal)
        sharedButton.tintColor = .secondaryLabel
        
    }
    
    private func layout() {
        addSubview(thumbnailImageView)
        addSubview(stackView)
        addSubview(favoriteImageView)
        addSubview(sharedButton)
        contentView.addSubview(sharedButton)
        contentView.bringSubviewToFront(sharedButton)
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(typeLabel)
        
        /// thumbnailImageView
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            thumbnailImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            thumbnailImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 120),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 120),
        ])
        
        /// stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: thumbnailImageView.trailingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
        ])
        
        /// sharedButton
        NSLayoutConstraint.activate([
            sharedButton.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            sharedButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            sharedButton.widthAnchor.constraint(equalToConstant: 20),
            sharedButton.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        
        /// favoriteImageView
        NSLayoutConstraint.activate([
            favoriteImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -55),
            favoriteImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            favoriteImageView.widthAnchor.constraint(equalToConstant: 25),
            favoriteImageView.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
}

// MARK: - Our Action Button andLogic
extension RestaurantCell {
    
    func set(restaurant: Restaurant) {
        thumbnailImageView.image    = UIImage(named: restaurant.image)
        nameLabel.text              = restaurant.name
        locationLabel.text          = restaurant.location
        typeLabel.text              = restaurant.type
    }
}
