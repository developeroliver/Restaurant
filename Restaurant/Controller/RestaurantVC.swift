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
    
    var restaurants:[Restaurant]    = [
        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "Hong Kong", image: "cafedeadend", isFavorite: false),
        Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong", image: "homei", isFavorite: false),
        Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong", image: "teakha", isFavorite: false),
        Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Hong Kong", image: "cafeloisl", isFavorite: false),
        Restaurant(name: "Petite Oyster", type: "French", location: "Hong Kong", image: "petiteoyster", isFavorite: false),
        Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Hong Kong", image: "forkee", isFavorite: false),
        Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong", image: "posatelier", isFavorite: false),
        Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "Sydney", image: "bourkestreetbakery", isFavorite: false),
        Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney", image: "haigh", isFavorite: false),
        Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Sydney", image: "palomino", isFavorite: false),
        Restaurant(name: "Upstate", type: "American", location: "New York", image: "upstate", isFavorite: false),
        Restaurant(name: "Traif", type: "American", location: "New York", image: "traif", isFavorite: false),
        Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "New York", image: "graham", isFavorite: false),
        Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "New York", image: "waffleandwolf", isFavorite: false),
        Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New York", image: "fiveleaves", isFavorite: false),
        Restaurant(name: "Cafe Lore", type: "Latin American", location: "New York", image: "cafelore", isFavorite: false),
        Restaurant(name: "Confessional", type: "Spanish", location: "New York", image: "confessional", isFavorite: false),
        Restaurant(name: "Barrafina", type: "Spanish", location: "London", image: "barrafina", isFavorite: false),
        Restaurant(name: "Donostia", type: "Spanish", location: "London", image: "donostia", isFavorite: false),
        Restaurant(name: "Royal Oak", type: "British", location: "London", image: "royaloak", isFavorite: false),
        Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "London", image: "cask", isFavorite: false)
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
        title = "FoodPin"
        navigationController?.navigationBar.prefersLargeTitles = true
        
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
}


// MARK: - UITableViewDelegate
extension RestaurantVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let info = restaurants[indexPath.row]
        let detailVC = RestaurantDetailVC()
        
        detailVC.restaurant = info
        navigationController?.pushViewController(detailVC, animated: true)
        
        
        //        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        //
        //        if let popoverController = optionMenu.popoverPresentationController {
        //            if let cell = tableView.cellForRow(at: indexPath) {
        //                popoverController.sourceView = cell
        //                popoverController.sourceRect = cell.bounds
        //            }
        //        }
        //
        //        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        //        optionMenu.addAction(cancelAction)
        //
        //        let reserveActionHandler = { (action:UIAlertAction!) -> Void in
        //            let alertMessage = UIAlertController(title: "Not available yet", message: "Sorry, this feature is not available yet. Please retry later.", preferredStyle: .alert)
        //            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        //            self.present(alertMessage, animated: true, completion: nil)
        //        }
        //
        //        // Add "Reserve a table" action
        //        let reserveAction = UIAlertAction(title: "Reserve a table", style: .default, handler: reserveActionHandler)
        //        optionMenu.addAction(reserveAction)
        //
        //        // Add "favorites and remove" action
        //        let favoriteActionTitle = self.restaurantIsFavorites[indexPath.row] ? "Remove from favorites" : "Mark as favorite"
        //
        //        let favoriteAction = UIAlertAction(title: favoriteActionTitle, style: .default, handler: {
        //            (action:UIAlertAction!) -> Void in
        //            let cell = tableView.cellForRow(at: indexPath) as! RestaurantCell
        //            cell.favoriteImageView.isHidden = self.restaurantIsFavorites[indexPath.row]
        //            self.restaurantIsFavorites[indexPath.row].toggle()
        //        })
        //        optionMenu.addAction(favoriteAction)
        //
        //        present(optionMenu, animated: true, completion: nil)
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
            let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 0, 0 )
            cell.layer.transform = rotationTransform
            
            // Define the final state (After the animation)
            UIView.animate(withDuration: 1.5)  { cell.layer.transform = CATransform3DIdentity }
            
        }
}
