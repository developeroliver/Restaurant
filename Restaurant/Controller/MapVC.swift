//
//  MapVC.swift
//  Restaurant
//
//  Created by olivier geiger on 29/03/2024.
//

import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate {
    
    var restaurant = Restaurant()
    let mapView = MKMapView()
    let openMapsButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        style()
        layout()
        setupBackButton()
    }
}

// MARK: - Our Action Button and Logic
extension MapVC {
    
    private func setupBackButton() {
        let backButtonImage = UIImage(systemName: "arrow.backward", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20.0, weight: .bold))
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = UIColor(named: "NavigationBarTitle")
        navigationItem.leftBarButtonItem = backButton
        
        let openMapsImage = UIImage(systemName: "car.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30.0, weight: .bold))
        let rightButton = UIBarButtonItem(image: openMapsImage, style: .plain, target: self, action: #selector(openMapsButtonTapped))
        rightButton.tintColor = UIColor(named: "NavigationBarTitle")
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func openMapsButtonTapped() {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location, completionHandler: { placemarks, error in
            if let error = error {
                print(error)
                return
            }
            
            if let placemarks = placemarks, let placemark = placemarks.first, let location = placemark.location {
                let coordinates = location.coordinate
                let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinates))
                mapItem.name = self.restaurant.name
                mapItem.openInMaps(launchOptions: nil)
            }
        })
    }
}

// MARK: - Our Style and layout {
extension MapVC {
    
    private func style() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsTraffic = true
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location, completionHandler: { placemarks, error in
            if let error = error {
                print(error)
                return
            }
            
            if let placemarks = placemarks {
                let placemark = placemarks[0]
                let annotation = MKPointAnnotation()
                annotation.title = self.restaurant.name
                annotation.subtitle = self.restaurant.type
                
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
            }
        })
    }
    
    private func layout() {
        view.addSubview(mapView)
        
        /// mapView
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 0),
            mapView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: mapView.trailingAnchor, multiplier: 0),
            mapView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.bottomAnchor, multiplier: 0)
        ])
    }
}




