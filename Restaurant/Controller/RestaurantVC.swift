//
//  ViewController.swift
//  Restaurant
//
//  Created by olivier geiger on 24/03/2024.
//

import UIKit

class RestaurantVC: UIViewController {
    var selectedIndexPath: IndexPath?
    private var dataSource: UITableViewDiffableDataSource<Int, Restaurant>!
    
    var restaurants:[Restaurant] = [
        Restaurant(name: "L'art du café", type: "Salon de Café et thé", location: "Illkirch", image: "cafedeadend", isFavorite: false),
        Restaurant(name: "Café Broglie", type: "Salon de Café", location: "Strasbourg", image: "homei", isFavorite: false),
        Restaurant(name: "Au Fond de la Théière", type: "Maison du thé", location: "Strasbourg", image: "teakha", isFavorite: false),
        Restaurant(name: "Le Café Monceau", type: "Salon de Café et thé", location: "Illkirch", image: "cafeloisl", isFavorite: false),
        Restaurant(name: "Le chasseur", type: "Restaurant", location: "Illkirch", image: "petiteoyster", isFavorite: false),
        Restaurant(name: "Au vieux Strasbourg", type: "Restaurant", location: "Strabourg", image: "forkee", isFavorite: false),
        Restaurant(name: "Pains WŒRLÉ", type: "Boulangerie", location: "Strasbourg", image: "posatelier", isFavorite: false),
        Restaurant(name: "Boulangerie Beck", type: "Boulangerie", location: "Illkirch", image: "bourkestreetbakery", isFavorite: false),
        Restaurant(name: "Schaal chocolatier", type: "Salon de café", location: "Geispolsheim", image: "haigh", isFavorite: false),
        Restaurant(name: "Au Hussard", type: "Salon de café", location: "Osswald", image: "palomino", isFavorite: false),
        Restaurant(name: "La Hache", type: "Restaurant", location: "Strasbourg", image: "upstate", isFavorite: false),
        Restaurant(name: "Buffalo Grill", type: "Restauration rapide", location: "Geispolsheim", image: "traif", isFavorite: false),
        Restaurant(name: "La Croix de Savoie", type: "Restaurant", location: "Illkirch", image: "graham", isFavorite: false),
        Restaurant(name: "Café de l'Opéra", type: "Salon de café et thé", location: "Strabourg", image: "waffleandwolf", isFavorite: false),
        Restaurant(name: "Café Atlantico", type: "Boulangerie", location: "Strasbourg, Orangerie", image: "fiveleaves", isFavorite: false),
        Restaurant(name: "Café Lore", type: "Salon de café", location: "Strasbourg", image: "cafelore", isFavorite: false),
        Restaurant(name: "Bella Vita", type: "Spanish", location: "Strasbourg", image: "confessional", isFavorite: false),
        Restaurant(name: "Del Arte", type: "Restaurant", location: "Illkirch", image: "barrafina", isFavorite: false),
        Restaurant(name: "L'Impasto", type: "Restaurant", location: "Illkirch", image: "donostia", isFavorite: false),
        Restaurant(name: "Ô Brocomagus", type: "Restaurant", location: "Brumath", image: "royaloak", isFavorite: false),
        Restaurant(name: "La Halle aux Blés", type: "Restaurant", location: "Obernai", image: "cask", isFavorite: false)
    ]
    
    var restaurantIsFavorites       = Array(repeating: false, count: 21)
    lazy var restaurantShown        = [Bool](repeating: false, count: restaurants.count)
    let tableView                   = UITableView()
    
    
    // MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        dataSource = setupDataSource()
        setupInitialSnapshot()
    }
    
    
    // MARK: - UITableView
    private func style() {
        tableView.cellLayoutMarginsFollowReadableWidth = true
        view.backgroundColor = .systemBackground
        title = "Les bons plans"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        addButton.tintColor = .label
        
        view.addSubview(tableView)
        tableView.frame     = view.bounds
        tableView.rowHeight = 140
        tableView.separatorStyle = .none
        tableView.register(RestaurantCell.self, forCellReuseIdentifier: RestaurantCell.reuseID)
        tableView.delegate = self
    }
    
    
    // MARK: - UITableView Diffable Data Source
    private func setupDataSource() -> RestaurantDiffableDataSource{
        
        let dataSource = RestaurantDiffableDataSource(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, restaurant in
                let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantCell.reuseID, for: indexPath) as! RestaurantCell
                
                cell.backgroundColor = .clear
                cell.set(restaurant: restaurant)
                cell.favoriteImageView.isHidden = restaurant.isFavorite ? false : true
                cell.sharedButton.addTarget(self, action: #selector(self.handleSharedButton), for: .touchUpInside)
                return cell
            }
        )
        
        return dataSource
    }
    
    
    // MARK: - DataSource snapshot
    private func setupInitialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Restaurant>()
        snapshot.appendSections([0])
        snapshot.appendItems(restaurants, toSection: 0)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    
    // MARK: - Action Button
    @objc func handleSharedButton(_ sender: AnyObject) {
        // Get the selected row
        let buttonPosition = sender.convert(CGPoint.zero, to: tableView)
        
        guard tableView.indexPathForRow(at: buttonPosition) != nil else {
            return
        }
        
        // Display the share menu
        let shareMenu = UIAlertController(title: nil, message: "Partager sur ", preferredStyle: .actionSheet)
        
        // Add actions for Facebook, Twitter, Instagram, and Cancel
        let facebookAction = UIAlertAction(title: "Facebook", style: .default, handler: nil)
        let twitterAction = UIAlertAction(title: "Twitter", style: .default, handler: nil)
        let instagramAction = UIAlertAction(title: "Instagram", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
        
        // Add actions to the share menu
        shareMenu.addAction(facebookAction)
        shareMenu.addAction(twitterAction)
        shareMenu.addAction(instagramAction)
        shareMenu.addAction(cancelAction)
        
        // Present the share menu
        self.present(shareMenu, animated: true, completion: nil)
    }
    
    @objc func addButtonTapped() {
        print("Add")
    }
}


// MARK: - UITableViewDelegate
extension RestaurantVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let info = restaurants[indexPath.row]
        let detailVC = RestaurantDetailVC()
        
        detailVC.restaurant = info
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Get the selected restaurant
        guard let restaurant = self.dataSource.itemIdentifier(for: indexPath) else {
            return UISwipeActionsConfiguration()
        }
        
        // Delete action
        let deleteAction = UIContextualAction(style: .destructive, title: "Supprimer") { (action, sourceView, completionHandler) in
            
            var snapshot = self.dataSource.snapshot()
            snapshot.deleteItems([restaurant])
            self.dataSource.apply(snapshot, animatingDifferences: true)
            
            // Call completion handler to dismiss the action button
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = .systemRed
        deleteAction.image = UIImage(systemName: "trash")
        
        // Share action
        let shareAction = UIContextualAction(style: .normal, title: "Partager") {
            (action, sourceView, completionHandler) in
            
            let defaultText = "Je viens de m'enregistrer chez " + restaurant.name
            
            let activityController: UIActivityViewController
            
            if let imageToShare = UIImage(named: restaurant.image) {
                activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            } else {
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            }
            
            if let popoverController = activityController.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath) {
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                } }
            
            self.present(activityController, animated: true, completion: nil)
            completionHandler(true)
        }
        
        shareAction.backgroundColor = UIColor.systemOrange
        shareAction.image = UIImage(systemName: "square.and.arrow.up")
        
        // Configure both action as swipe action
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        
        return swipeConfiguration
    }
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Get the selected restaurant
        guard let restaurant = self.dataSource.itemIdentifier(for: indexPath) else {
            return UISwipeActionsConfiguration()
        }
        
        // Mark as favorite action
        let favoriteAction = UIContextualAction(style: .destructive, title: "") { (action, sourceView, completionHandler) in
            
            let cell = tableView.cellForRow(at: indexPath) as! RestaurantCell
            
            cell.favoriteImageView.isHidden = self.restaurants[indexPath.row].isFavorite
            
            self.restaurants[indexPath.row].isFavorite = self.restaurants[indexPath.row].isFavorite ? false : true
            
            // Call completion handler to dismiss the action button
            completionHandler(true)
        }
        
        // Configure swipe action
        favoriteAction.backgroundColor = UIColor.systemYellow
        favoriteAction.image = UIImage(systemName: self.restaurants[indexPath.row].isFavorite ? "heart.slash.fill" : "heart.fill")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [favoriteAction])
        
        return swipeConfiguration
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if restaurantShown[indexPath.row] {
            return
        }
        
        // Indicate the post has been displayed, so the animation won't be displayed again
        restaurantShown[indexPath.row] = true
        
        // Define the initial state (Before the animation)
        let leadingAnimation = CATransform3DTranslate(CATransform3DIdentity, -500, 0, 0 )
        cell.layer.transform = leadingAnimation
        
        // Define the final state (After the animation)
        UIView.animate(withDuration: 0.7, delay: TimeInterval(indexPath.row) * 0.1, options: .curveEaseInOut, animations: {
            cell.layer.transform = CATransform3DIdentity
        }, completion: nil)
        
    }
}
