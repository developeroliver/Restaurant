//
//  RestaurantDetailVC.swift
//  Restaurant
//
//  Created by olivier geiger on 25/03/2024.
//

import UIKit
import MapKit

class RestaurantDetailVC: UIViewController, RatingViewDelegate {
    
    var restaurant: Restaurant?
    // ajout d'une variable
    var selectedRating: Int = 0
    
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
    let ratingText          = UILabel()
    let mapView             = MKMapView()
    let rateButton          = CustomButton(backgroundColor: UIColor(named: "NavigationBarTitle")!, title: "Évaluer")
    let ratingView          = RatingView()
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        setupBackButton()
        configure(location: restaurant!.location)
        ratingView.delegate = self
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
    
    @objc func handleRateButton() {
        
        let alert = UIAlertController(title: "Donnez une évaluation", message: nil, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if self.selectedRating == 0 {
                self.ratingText.text = ""
            } else {
                self.ratingText.text = "Évaluation: \(self.starsString(for: self.selectedRating))"
            }
            
            UIView.animate(withDuration: 0.5) {
                self.ratingText.frame.origin = CGPoint(x: 100, y: 100)
            }

        }
        
        let cancelAction = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        selectedRating = 0
        
        alert.view.addSubview(ratingView)
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ratingView.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 70),
            ratingView.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor),
            ratingView.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: -30),
            ratingView.widthAnchor.constraint(equalToConstant: 240),
            ratingView.heightAnchor.constraint(equalToConstant: 84)
        ])
        
        present(alert, animated: true, completion: nil)
        
        // Adding rating view to action buttons
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ratingViewTapped(_:)))
        ratingView.addGestureRecognizer(tapGesture)
    }
    
    @objc func ratingViewTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        // Prevent the tap from dismissing the alert
        gestureRecognizer.isEnabled = false
    }
    
    func ratingView(_ ratingView: RatingView, didUpdateRating rating: Int) {
        selectedRating = rating
        // Do something with the selected rating
        print("Selected rating: \(rating)")
    }
    
    private func starsString(for rating: Int) -> String {
        // Créer une chaîne de caractères composée d'étoiles en fonction de la valeur de l'évaluation
        return String(repeating: "⭐️", count: rating)
    }
    
    @objc func mapTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            
            let destination = MapVC()
            destination.restaurant = restaurant!
            navigationController?.pushViewController(destination, animated: true)
        }
    }
    
    private func configure(location: String) {
        // Get location
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(location, completionHandler: { placemarks, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let placemarks = placemarks {
                // Get the first placemark
                let placemark = placemarks[0]
                // Add annotation
                let annotation = MKPointAnnotation()
                if let location = placemark.location {
                    // Display the annotation
                    annotation.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotation)
                    // Set the zoom level
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
                    self.mapView.setRegion(region, animated: false)
                }
            }
        })
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
        descriptionLabel.numberOfLines = 4
        descriptionLabel.lineBreakMode = .byTruncatingTail
        
        /// addressLabel
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.text           = "Adresse"
        addressLabel.textColor      = .label
        addressLabel.font           = UIFont.boldSystemFont(ofSize: 20.0)
        
        /// addressText
        addressText.translatesAutoresizingMaskIntoConstraints = false
        addressText.text                        = restaurant?.location
        addressText.textColor                   = .label
        addressText.numberOfLines               = 2
        addressText.lineBreakMode               = .byTruncatingTail
        addressText.isUserInteractionEnabled    = true
        
        /// phoneLabel
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.text         = "Téléphone"
        phoneLabel.textColor    = .label
        phoneLabel.font          = UIFont.boldSystemFont(ofSize: 20.0)
        
        /// phoneText
        phoneText.translatesAutoresizingMaskIntoConstraints = false
        phoneText.text      = restaurant?.phone
        phoneText.textColor = .label
        
        /// ratingText
        ratingText.translatesAutoresizingMaskIntoConstraints = false
        ratingText.text          = ""
        ratingText.textColor     = .label
        ratingText.font          = UIFont.boldSystemFont(ofSize: 20.0)
        
        /// mapView
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.layer.cornerRadius = 20
        mapView.clipsToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(mapTapped(_:)))
        mapView.addGestureRecognizer(tapGesture)
        
        /// rateButton
        rateButton.addTarget(self, action: #selector(handleRateButton), for: .touchUpInside)
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
        view.addSubview(ratingText)
        view.addSubview(mapView)
        view.addSubview(rateButton)
        
        /// thumbnailImageView
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: view.topAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 270),
        ])
        
        /// heartButton
        NSLayoutConstraint.activate([
            heartButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 0),
            heartButton.trailingAnchor.constraint(equalToSystemSpacingAfter: view.layoutMarginsGuide.trailingAnchor, multiplier: -2),
            heartButton.widthAnchor.constraint(equalToConstant: 50),
            heartButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        /// stackView
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
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
        
        /// ratingText
        NSLayoutConstraint.activate([
            ratingText.topAnchor.constraint(equalToSystemSpacingBelow: phoneText.bottomAnchor, multiplier: 1),
            ratingText.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: ratingText.leadingAnchor, multiplier: 2),
        ])
        
        /// mapView
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalToSystemSpacingBelow: ratingText.bottomAnchor, multiplier: 2),
            mapView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: mapView.trailingAnchor, multiplier: 2),
        ])
        
        /// rateButton
        NSLayoutConstraint.activate([
            rateButton.topAnchor.constraint(equalToSystemSpacingBelow: mapView.bottomAnchor, multiplier: 2),
            rateButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: rateButton.trailingAnchor, multiplier: 2),
            rateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 2),
            rateButton.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
}


