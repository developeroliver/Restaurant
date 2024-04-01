//
//  NewRestaurantVC.swift
//  Restaurant
//
//  Created by olivier geiger on 30/03/2024.
//

import UIKit

class NewRestaurantViewController: UIViewController {
    
    let titleLabel              = UILabel()
    let thumbnailImageView      = UIImageView()
    let stackView               = UIStackView()
    let nameLabel               = UILabel()
    let nameTextField           = UITextField()
    let typeLabel               = UILabel()
    let typeTextField           = UITextField()
    let addressLabel            = UILabel()
    let addressTextField        = UITextField()
    let phoneLabel              = UILabel()
    let phoneTextField          = UITextField()
    let descriptionLabel        = UILabel()
    let descriptionTextView     = UITextView()
    let addButton               = CustomButton(backgroundColor: UIColor(named: "NavigationBarTitle")!, title: "Valider")
    
    /// LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        style()
        layout()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
}

// MARK: - Our Action Button and Logic
extension NewRestaurantViewController {
    
    @objc func handleAddButton() {
        let alert = UIAlertController(title: "Fonctionnalité non disponible", message: "Cette fonctionnalité n'est pas encore disponible.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                self.view.frame.origin.y = -keyboardSize.height + 100
            }
        }

        @objc func keyboardWillHide(notification: NSNotification) {
            self.view.frame.origin.y = 0
        }
    
    @objc func dismissKeyboard() {
            view.endEditing(true)
        }
}

// MARK: - Our Style and Layout
extension NewRestaurantViewController {
    
    private func style() {
        view.backgroundColor = .systemBackground
        
        /// titleLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Nouveau lieu"
        titleLabel.textColor = UIColor(named: "NavigationBarTitle")
        titleLabel.font = UIFont(name: "Nunito-Bold", size: 40.0)
        
        /// thumbnailImageView
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.image = UIImage(named: "newphoto")
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.backgroundColor = .systemGray6
        thumbnailImageView.layer.cornerRadius = 20
        
        /// stackView
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        /// nameLabel
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Nom"
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
        /// nameTextField
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.placeholder = "Entrer le nom du lieu"
        nameTextField.borderStyle = .roundedRect
        nameTextField.delegate    = self
        
        /// typeLabel
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.text = "Type"
        typeLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
        /// typeTextField
        typeTextField.translatesAutoresizingMaskIntoConstraints = false
        typeTextField.placeholder = "Entrer le type du lieu"
        typeTextField.borderStyle = .roundedRect
        typeTextField.delegate    = self
        
        /// addressLabel
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.text = "Adresse"
        addressLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
        /// addressTextField
        addressTextField.translatesAutoresizingMaskIntoConstraints = false
        addressTextField.placeholder = "Entrer l'adresse' du lieu"
        addressTextField.borderStyle = .roundedRect
        addressTextField.delegate    = self
        
        /// phoneLabel
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.text = "Téléphone"
        phoneLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
        /// phoneTextField
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneTextField.placeholder = "Entrer le téléphone du lieu"
        phoneTextField.borderStyle = .roundedRect
        phoneTextField.delegate    = self
        
        /// descriptionLabel
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "Description"
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
        /// descriptionTextView
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.cornerRadius = 10
        descriptionTextView.layer.masksToBounds = true
        descriptionTextView.layer.borderColor = UIColor.gray.cgColor
        descriptionTextView.textContainer.maximumNumberOfLines = 5
        descriptionTextView.textContainer.lineBreakMode = .byTruncatingTail
        descriptionTextView.contentMode = .top
        descriptionTextView.backgroundColor = .systemGray6
        
        /// addButton
        addButton.addTarget(self, action: #selector(handleAddButton), for: .touchUpInside)
    }
    
    private func layout() {
        view.addSubview(titleLabel)
        view.addSubview(thumbnailImageView)
        view.addSubview(addButton)
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(typeLabel)
        stackView.addArrangedSubview(typeTextField)
        stackView.addArrangedSubview(addressLabel)
        stackView.addArrangedSubview(addressTextField)
        stackView.addArrangedSubview(phoneLabel)
        stackView.addArrangedSubview(phoneTextField)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(descriptionTextView)
        
        view.addSubview(stackView)
        
        /// titleLabel
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 1),
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: titleLabel.trailingAnchor, multiplier: 2),
        ])
        
        
        ///thumbnailImageView
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1),
            thumbnailImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            thumbnailImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 170),
        ])
        
        /// StackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: thumbnailImageView.bottomAnchor, multiplier: 2),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.leadingAnchor, multiplier: 2),
            
            nameTextField.widthAnchor.constraint(equalToConstant: 350),
        ])
        
        /// addButton
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 2),
            addButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: addButton.trailingAnchor, multiplier: 2),
            addButton.heightAnchor.constraint(equalToConstant: 45),
            addButton.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 2),
        ])
        
    }
}

// MARK: - UITextFieldDelegate
extension NewRestaurantViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           
            switch textField {
            case nameTextField:
                typeTextField.becomeFirstResponder()
            case typeTextField:
                addressTextField.becomeFirstResponder()
            case addressTextField:
                phoneTextField.becomeFirstResponder()
            case phoneTextField:
                descriptionTextView.becomeFirstResponder()
            default:
                textField.resignFirstResponder() // Cache le clavier
            }
            
            return true
        }

}
