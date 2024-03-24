//
//  ViewController.swift
//  Restaurant
//
//  Created by olivier geiger on 24/03/2024.
//

import UIKit

class RestaurantVC: UIViewController {
    
    var selectedIndexPath: IndexPath?
    
    var restaurantNames = [
        "Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery"
        , "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats And Deli", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"
    ] {
            didSet {
                applySnapshot()
            }
        }
    
    
    lazy var dataSource = UITableViewDiffableDataSource<Int, String>(tableView: tableView) { tableView, indexPath, name in
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantCell.reuseID, for: indexPath) as! RestaurantCell
        cell.accessoryType = .disclosureIndicator
        cell.set(withName: name, imageView: cell.imageView!)
        return cell
    }
    
    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        style()
        applySnapshot()
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(restaurantNames)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - Style Extensions
extension RestaurantVC {
    
    private func style() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.register(RestaurantCell.self, forCellReuseIdentifier: RestaurantCell.reuseID)
    }
}


// MARK: Table view data source
extension RestaurantVC:  UITableViewDelegate {
    
    
    
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
