//
//  ViewController.swift
//  Restaurant
//
//  Created by olivier geiger on 24/03/2024.
//

import UIKit

class RestaurantVC: UIViewController {
    
    var selectedIndexPath: IndexPath?
    
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery"
    , "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats And Deli", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    let tableView       = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        style()
        layout()
    }


    override var prefersStatusBarHidden: Bool {
        return true
    }
}


// MARK: our style
extension RestaurantVC {
    
    private func style() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate   = self
        tableView.register(RestaurantCell.self, forCellReuseIdentifier: RestaurantCell.reuseID)
    }
}


// MARK: our layout
extension RestaurantVC {
    
    private func layout() {
        
    }
}


// MARK: our DataSourc and Delegate
extension RestaurantVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantNames.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: RestaurantCell.reuseID, for: indexPath) as! RestaurantCell
        cell.accessoryType = .disclosureIndicator
        let names = restaurantNames[indexPath.row]
        cell.imageView?.image = UIImage(named: "Petite Oyster")
        cell.set(withName: names, imageView: cell.imageView!)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Si une cellule était déjà sélectionnée, réinitialisez sa couleur
            if let previousSelectedIndexPath = selectedIndexPath {
                let previousSelectedCell = tableView.cellForRow(at: previousSelectedIndexPath)
                previousSelectedCell?.backgroundColor = .clear
            }
            
            // Mettez à jour la cellule sélectionnée et changez sa couleur
            selectedIndexPath = indexPath
            let selectedCell = tableView.cellForRow(at: indexPath)
            selectedCell?.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.3) // Choisissez la couleur de votre choix
            
            // Désélectionnez la cellule pour éviter que la couleur sélectionnée ne reste
            tableView.deselectRow(at: indexPath, animated: true)
        }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
