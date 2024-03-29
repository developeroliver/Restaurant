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
    let heartButton         = UIButton(type: .system)
    let stackView           = UIStackView()
    let nameLabel           = UILabel()
    let locationLabel       = UILabel()
    let typeLabel           = UILabel()
    let descStackView       = UIStackView()
    let descriptionLabel    = UILabel()
    let addressLabel        = UILabel()
    let addressText         = UILabel()
    let phoneLabel          = UILabel()
    let phoneText           = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        setupBackButton()
    }
    
    
    private func setupBackButton() {
        let backButtonImage = UIImage(systemName: "arrow.backward", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20.0, weight: .bold))
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
    }
    
    
    // MARK: Add our style
    private func style() {
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.image = UIImage(named: restaurant!.image)
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true
        
        heartButton.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis          = .vertical
        stackView.distribution  = .equalSpacing
        stackView.alignment     = .leading
        stackView.spacing       = 10
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text          = restaurant?.name
        nameLabel.textColor     = .white
        nameLabel.layer.shadowOpacity = 0.5
        nameLabel.layer.shadowOffset = CGSize(width: 2, height: 2)
        nameLabel.numberOfLines = 0
        nameLabel.lineBreakMode = .byTruncatingTail
        if let customFont = UIFont(name: "Nunito-Bold", size: 40.0) {
            nameLabel.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: customFont)
        }
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.text = restaurant?.location
        
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.text          = restaurant?.type
        typeLabel.textColor     = .white
        if let customFont = UIFont(name: "Nunito-Bold", size: 20.0) {
            typeLabel.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: customFont)
        }
        typeLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text       = restaurant?.description
        descriptionLabel.textColor  = .label
        descriptionLabel.numberOfLines = 5
        descriptionLabel.lineBreakMode = .byTruncatingTail
        
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.text       = "Adresse"
        addressLabel.textColor  = .label
        addressLabel.font       = UIFont.boldSystemFont(ofSize: 20.0)
        
        addressText.translatesAutoresizingMaskIntoConstraints = false
        addressText.text        = restaurant?.location
        addressText.textColor   = .label
        
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.text         = "Téléphone"
        phoneLabel.textColor    = .label
        phoneLabel.font          = UIFont.boldSystemFont(ofSize: 20.0)
        
        phoneText.translatesAutoresizingMaskIntoConstraints = false
        phoneText.text      = restaurant?.phone
        phoneText.textColor = .label
    }
    
    
    // MARK: - Add our layout
    private func layout() {
        view.addSubview(thumbnailImageView)
        view.addSubview(heartButton)
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(typeLabel)
        
        view.addSubview(descriptionLabel)
        view.addSubview(addressLabel)
        view.addSubview(addressText)
        view.addSubview(phoneLabel)
        view.addSubview(phoneText)
        
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: view.topAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 520),
            
            heartButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -10),
            heartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            heartButton.widthAnchor.constraint(equalToConstant: 30),
            heartButton.heightAnchor.constraint(equalToConstant: 30),
            
            stackView.bottomAnchor.constraint(equalTo: heartButton.bottomAnchor, constant: 370),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -120),
            
            descriptionLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            addressLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            addressText.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 5),
            addressText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addressText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            phoneLabel.topAnchor.constraint(equalTo: addressText.bottomAnchor, constant: 20),
            phoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phoneLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            phoneText.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 5),
            phoneText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phoneText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
    }
    
    
    // MARK: - Action Button
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

}
