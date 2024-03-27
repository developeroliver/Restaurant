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
    
    
    // MARK: our style
    private func setupStyle() {
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.contentMode          = .scaleAspectFit
        thumbnailImageView.layer.cornerRadius   = 20
        thumbnailImageView.layer.masksToBounds  = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis          = .vertical
        stackView.distribution  = .fill
        stackView.alignment     = .top
        stackView.spacing       = 4
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.textColor     = UIColor.secondaryLabel
        typeLabel.font          = UIFont.preferredFont(forTextStyle: .subheadline)
        
        favoriteImageView.translatesAutoresizingMaskIntoConstraints = false
        favoriteImageView.image = UIImage(systemName: "heart.fill")
        favoriteImageView.tintColor = .systemYellow
        
        sharedButton.translatesAutoresizingMaskIntoConstraints = false
        sharedButton.setImage(UIImage(named: "share"), for: .normal)
        sharedButton.tintColor = .secondaryLabel
        
    }
    
    
    // MARK: our layout
    private func layout() {
        addSubview(thumbnailImageView)
        addSubview(stackView)
        addSubview(favoriteImageView)
        contentView.addSubview(sharedButton)
        contentView.bringSubviewToFront(sharedButton)
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(typeLabel)
        
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            thumbnailImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            thumbnailImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 120),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 120),
            
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            
            sharedButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            sharedButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            sharedButton.widthAnchor.constraint(equalToConstant: 20),
            sharedButton.heightAnchor.constraint(equalToConstant: 20),
            
            favoriteImageView.topAnchor.constraint(equalTo: sharedButton.bottomAnchor, constant: 10),
            favoriteImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            favoriteImageView.widthAnchor.constraint(equalToConstant: 25),
            favoriteImageView.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
    
    
    // MARK: - Our logic
    func set(restaurant: Restaurant) {
        thumbnailImageView.image    = UIImage(named: restaurant.image)
        nameLabel.text              = restaurant.name
        locationLabel.text          = restaurant.location
        typeLabel.text              = restaurant.type
    }
}
