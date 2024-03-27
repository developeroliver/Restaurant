//
//  RestaurantDetailVC.swift
//  Restaurant
//
//  Created by olivier geiger on 25/03/2024.
//

import UIKit

class RestaurantDetailVC: UIViewController {
    
    var restaurant: Restaurant?
    
    let thumbnailImageView  = UIImageView()
    let containerView       = UIView()
    let stackView           = UIStackView()
    let nameLabel           = UILabel()
    let locationLabel       = UILabel()
    let typeLabel           = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    
    private func style() {
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = .label
        
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.image = UIImage(named: restaurant!.image)
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .lightGray
        containerView.layer.cornerRadius = 10
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis          = .vertical
        stackView.distribution  = .equalSpacing
        stackView.alignment     = .center
        stackView.spacing       = 4
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = restaurant?.name
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.text = restaurant?.location
        
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.text = restaurant?.type
    }
    
    
    private func layout() {
        view.addSubview(thumbnailImageView)
        view.addSubview(containerView)
        containerView.addSubview(stackView)
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(typeLabel)
        
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: view.topAnchor),
            thumbnailImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerView.heightAnchor.constraint(equalToConstant: 100),
            
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5)
        ])
        
    }
}
