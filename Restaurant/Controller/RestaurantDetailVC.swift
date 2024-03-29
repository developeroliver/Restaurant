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
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        setupBackButton()
    }
}

// MARK: - Our Style and Layout
extension RestaurantDetailVC {
    
    private func style() {
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        
        /// thumbnailImageView
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.image = UIImage(named: restaurant!.image)
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true
        
        /// heartButton
        heartButton.translatesAutoresizingMaskIntoConstraints = false
        
        /// stackView
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis          = .vertical
        stackView.distribution  = .equalSpacing
        stackView.alignment     = .leading
        stackView.spacing       = 10
        
        /// nameLabel
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
        
        /// locationLabel
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.text = restaurant?.location
        
        /// typeLabel
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.text          = restaurant?.type
        typeLabel.textColor     = .white
        if let customFont = UIFont(name: "Nunito-Bold", size: 20.0) {
            typeLabel.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: customFont)
        }
        typeLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        /// descriptionLabel
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text       = restaurant?.description
        descriptionLabel.textColor  = .label
        descriptionLabel.numberOfLines = 5
        descriptionLabel.lineBreakMode = .byTruncatingTail
        
        /// addressLabel
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.text           = "Adresse"
        addressLabel.textColor      = .label
        addressLabel.font           = UIFont.boldSystemFont(ofSize: 20.0)
        
        /// addressText
        addressText.translatesAutoresizingMaskIntoConstraints = false
        addressText.text        = restaurant?.location
        addressText.textColor   = .label
        addressText.numberOfLines  = 2
        addressText.lineBreakMode  = .byTruncatingTail
        
        /// phoneLabel
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.text         = "Téléphone"
        phoneLabel.textColor    = .label
        phoneLabel.font          = UIFont.boldSystemFont(ofSize: 20.0)
        
        /// phoneText
        phoneText.translatesAutoresizingMaskIntoConstraints = false
        phoneText.text      = restaurant?.phone
        phoneText.textColor = .label
    }
    
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
        
        /// thumbnailImageView
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: view.topAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 520),
        ])
        
        /// heartButton
        NSLayoutConstraint.activate([
            heartButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            heartButton.trailingAnchor.constraint(equalToSystemSpacingAfter: view.layoutMarginsGuide.trailingAnchor, multiplier: -2),
            heartButton.widthAnchor.constraint(equalToConstant: 30),
            heartButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        /// stackView
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: heartButton.bottomAnchor, constant: 370),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -120),
        ])
        
        /// descriptionLabel
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        /// addressLabel
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalToSystemSpacingBelow: descriptionLabel.bottomAnchor, multiplier: 2),
            addressLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: addressLabel.leadingAnchor, multiplier: 2),
        ])
        
        /// addressText
        NSLayoutConstraint.activate([
            addressText.topAnchor.constraint(equalToSystemSpacingBelow: addressLabel.bottomAnchor, multiplier: 1),
            addressText.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            addressText.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 2)

        ])
        
        /// phoneLabel
        NSLayoutConstraint.activate([
            phoneLabel.topAnchor.constraint(equalToSystemSpacingBelow: addressText.bottomAnchor, multiplier: 1),
            phoneLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: phoneLabel.leadingAnchor, multiplier: 2),
        ])
        
        /// phoneText
        NSLayoutConstraint.activate([
            phoneText.topAnchor.constraint(equalToSystemSpacingBelow: phoneLabel.bottomAnchor, multiplier: 1),
            phoneText.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: phoneText.leadingAnchor, multiplier: 2),
        ])
    }
}

// MARK: - Action Button and Logic
extension RestaurantDetailVC {
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupBackButton() {
        let backButtonImage = UIImage(systemName: "arrow.backward", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20.0, weight: .bold))
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
    }
}
