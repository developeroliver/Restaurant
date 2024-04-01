//
//  NewRestaurantVC.swift
//  Restaurant
//
//  Created by olivier geiger on 31/03/2024.
//

import UIKit

class NewRestaurantVC: UIViewController {
    
    let tableView = UITableView()
    var selectedImage: UIImage?
    var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "newphoto")
        return imageView
    }()
    
    /// LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: false)
    }
}

// MARK: - Our Style and Logic
extension NewRestaurantVC {
    
    private func style() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.bounds
        tableView.separatorStyle = .none
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
    }
}

// MARK: - Our Action Button and Logic
extension NewRestaurantVC {
    
    @objc func buttonTapped() {
        let alert = UIAlertController(title: "Fonctionnalité non disponible", message: "Cette fonctionnalité n'est pas encore disponible.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func leftButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        tableView.contentInset = contentInsets
        tableView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        tableView.contentInset = .zero
        tableView.scrollIndicatorInsets = .zero
    }
    
    func getTitle(forRow row: Int) -> String {
        switch row {
        case 1: return "Nom"
        case 2: return "Type"
        case 3: return "Adresse"
        case 4: return "Téléphone"
        case 5: return "Description"
        default: return ""
        }
    }
    
    func getPlaceholder(forRow row: Int) -> String {
        switch row {
        case 1: return "Entrer le nom"
        case 2: return "Entrer le type"
        case 3: return "Entrer l'adresse"
        case 4: return "Entrer le téléphone"
        case 5: return "Entrer la description"
        default: return ""
        }
    }
}


// MARK: - UITableViewDataSource, UITableViewDelegate
extension NewRestaurantVC: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    // MARK: - CellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.contentView.subviews.forEach { $0.removeFromSuperview() } // Réinitialiser les sous-vues de la cellule
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(stackView)
        
        switch indexPath.row {
        case 0:
            // Configurer l'image
            thumbnailImageView.contentMode = .scaleAspectFill
            thumbnailImageView.clipsToBounds = true
            thumbnailImageView.backgroundColor = .systemGray6
            thumbnailImageView.layer.cornerRadius = 20
            
            stackView.addArrangedSubview(thumbnailImageView)
            
            /// thumbnailImageView
            NSLayoutConstraint.activate([
                thumbnailImageView.topAnchor.constraint(equalTo: stackView.topAnchor),
                thumbnailImageView.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
                thumbnailImageView.heightAnchor.constraint(equalToConstant: 200),
            ])
        case 1:
            let nameLabel = UILabel()
            nameLabel.text = "Nom"
            stackView.addArrangedSubview(nameLabel)
            
            let nameTextField = UITextField()
            nameTextField.borderStyle = .roundedRect
            nameTextField.backgroundColor = .secondarySystemBackground
            nameTextField.placeholder = "Entrer un nom"
            nameTextField.tag = 1
            nameTextField.delegate = self
            stackView.addArrangedSubview(nameTextField)
        case 2:
            let typeLabel = UILabel()
            typeLabel.text = "Type"
            stackView.addArrangedSubview(typeLabel)
            
            let typeTextField = UITextField()
            typeTextField.borderStyle = .roundedRect
            typeTextField.backgroundColor = .secondarySystemBackground
            typeTextField.placeholder = "Entrer un type"
            typeTextField.tag = 2
            typeTextField.delegate = self
            stackView.addArrangedSubview(typeTextField)
        case 3:
            let addressLabel = UILabel()
            addressLabel.text = "Adress"
            stackView.addArrangedSubview(addressLabel)
            
            let addressTextField = UITextField()
            addressTextField.borderStyle = .roundedRect
            addressTextField.backgroundColor = .secondarySystemBackground
            addressTextField.placeholder = "Entrer une addresse"
            addressTextField.tag = 3
            addressTextField.delegate = self
            stackView.addArrangedSubview(addressTextField)
        case 4:
            let phoneLabel = UILabel()
            phoneLabel.text = "Téléphone"
            stackView.addArrangedSubview(phoneLabel)
            
            let phoneTextField = UITextField()
            phoneTextField.borderStyle = .roundedRect
            phoneTextField.backgroundColor = .secondarySystemBackground
            phoneTextField.placeholder = "Entrer un numéro de téléphone"
            phoneTextField.keyboardType = .phonePad
            phoneTextField.tag = 4
            phoneTextField.delegate = self
            stackView.addArrangedSubview(phoneTextField)
        case 5:
            let titleLabel = UILabel()
            titleLabel.text = getTitle(forRow: indexPath.row)
            stackView.addArrangedSubview(titleLabel)
            
            let descriptionTextView = UITextView()
            descriptionTextView.layer.borderWidth = 1
            descriptionTextView.layer.cornerRadius = 10
            descriptionTextView.layer.masksToBounds = true
            descriptionTextView.layer.borderColor = UIColor.gray.cgColor
            descriptionTextView.textContainer.maximumNumberOfLines = 5
            descriptionTextView.tag = 5
            descriptionTextView.textContainer.lineBreakMode = .byTruncatingTail
            descriptionTextView.contentMode = .top
            descriptionTextView.backgroundColor = .systemGray6
            stackView.addArrangedSubview(descriptionTextView)
        default:
            break
        }
        
        /// stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -8)
        ])
        
        return cell
    }
    
    // MARK: - heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        } else if indexPath.row >= 1 && indexPath.row <= 4 {
            return 70
        } else {
            return 130
        }
    }
    
    // MARK: - Header View Section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
        headerView.backgroundColor = .systemBackground
        
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: -5, width: 20, height: 20)
        backButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        backButton.tintColor = .label
        backButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        headerView.addSubview(backButton)
        
        let titleLabel = UILabel(frame: CGRect(x: 50, y: 10, width: tableView.frame.width - 40, height: 40))
        titleLabel.text = "Nouveau lieu"
        titleLabel.font = UIFont(name: "Nunito-Bold", size: 40.0)
        titleLabel.textColor = UIColor(named: "NavigationBarTitle")
        headerView.addSubview(titleLabel)
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.frame = CGRect(x: tableView.frame.width - 70, y: 10, width: 80, height: 40)
        button.tintColor = .label
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        headerView.addSubview(button)
        
        return headerView
    }
    
    
    // MARK: - Heigh for Header View Section
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    // MARK: - didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            let photoSourceRequestController = UIAlertController(title: nil, message: "Choose your photo source", preferredStyle: .actionSheet)
            
            /// Camera
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .camera
                    imagePicker.delegate = self
                    self.present(imagePicker, animated: true, completion: nil)
                }
            }
            
            /// Photo Library
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .photoLibrary
                    imagePicker.delegate = self
                    self.present(imagePicker, animated: true, completion: nil)
                }
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            
            photoSourceRequestController.addAction(cameraAction)
            photoSourceRequestController.addAction(photoLibraryAction)
            photoSourceRequestController.addAction(cancelAction)
            
            if let popoverController = photoSourceRequestController.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath) {
                    popoverController.sourceView = tableView.cellForRow(at: indexPath)
                    popoverController.sourceRect = cell.bounds
                }
            }
            
            present(photoSourceRequestController, animated: true, completion: nil)
        }
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension NewRestaurantVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            thumbnailImageView.image = selectedImage
            thumbnailImageView.contentMode = .scaleAspectFill
            thumbnailImageView.clipsToBounds = true
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        }
        
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate
extension NewRestaurantVC:  UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        
        return true
    }
}
