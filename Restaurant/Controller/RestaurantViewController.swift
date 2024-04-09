//
//  RestaurantViewController.swift
//  Restaurant
//
//  Created by olivier geiger on 24/03/2024.
//

import UIKit
import SwiftData

protocol RestaurantDataStore {
    func fetchRestaurantData()
    func updateSnapshot(animatingChange: Bool)
}

class RestaurantViewController: UIViewController, RestaurantDataStore {
    
    var container: ModelContainer?
    var selectedIndexPath: IndexPath?
    private var dataSource: UITableViewDiffableDataSource<Int, Restaurant>!
    
    var searchController: UISearchController!
    
    var restaurants: [Restaurant] = []
    var restaurantIsFavorites       = Array(repeating: false, count: 21)
    lazy var restaurantShown        = [Bool](repeating: false, count: restaurants.count)
    let tableView                   = UITableView()
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if UserDefaults.standard.bool(forKey: "hasViewedWalkthrough") { return }
        
        container = try? ModelContainer(for: Restaurant.self)
        
        if let appearance = navigationController?.navigationBar.standardAppearance
        {
            appearance.backgroundColor = .systemBackground
            if let customFont = UIFont(name: "Nunito-Bold", size: 45.0) {
                appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!]
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!, .font: customFont]
            }
        }
        
        navigationItem.hidesBackButton = true
        
        setup()
        searchControllerSetup()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        if !restaurants.isEmpty {
//            let indexPath = IndexPath(row: 0, section: 0)
//            tableView.scrollToRow(at: indexPath, at: .top, animated: false)
//        }
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserDefaults.standard.bool(forKey: "hasViewedWalkthrough") { return }
    }
}

// MARK: - Our Action Button and Logic
extension RestaurantViewController {
    
    private func setup() {
        restaurantShown = Array(repeating: false, count: restaurants.count)
        
        style()
        dataSource = setupDataSource()
        setupInitialSnapshot()
        
        view.addSubview(tableView)
        updateBackgroundImage()
        fetchRestaurantData()
    }
    
    private func searchControllerSetup() {
        searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Rechercher un spot"
        searchController.searchBar.tintColor = UIColor(named: "NavigationBarTitle")
        navigationItem.searchController = searchController
        definesPresentationContext = true    }
    
    private func setupInitialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Restaurant>()
        snapshot.appendSections([0])
        snapshot.appendItems(restaurants, toSection: 0)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func updateBackgroundImage() {
        if restaurants.isEmpty {
            let emptyDataImageView = UIImageView(image: UIImage(named: "emptydata"))
            emptyDataImageView.contentMode = .scaleAspectFit
            tableView.backgroundView = emptyDataImageView
        } else {
            tableView.backgroundView = nil
        }
    }
    
    func fetchRestaurantData() {
        fetchRestaurantData(searchText: "")
    }
    
    internal func fetchRestaurantData(searchText: String) {
        let descriptor: FetchDescriptor<Restaurant>
        
        if searchText.isEmpty {
            descriptor = FetchDescriptor<Restaurant>()
        } else {
            let predicate = #Predicate<Restaurant> { $0.name.localizedStandardContains(searchText) ||
                $0.location.localizedStandardContains(searchText)
            }
            
            descriptor = FetchDescriptor<Restaurant>(predicate: predicate)
        }

        restaurants = (try? container?.mainContext.fetch(descriptor)) ?? []
        
        updateSnapshot()

    }
    
    internal func updateSnapshot(animatingChange: Bool = false) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Restaurant>()
        snapshot.appendSections([0])
        snapshot.appendItems(restaurants, toSection: 0)
        
        dataSource.apply(snapshot, animatingDifferences: animatingChange)
        
        tableView.backgroundView?.isHidden = restaurants.count == 0 ? false : true
    }
    
    @objc func addNewRestaurant() {
        let addRestaurant = NewRestaurantVC()
        addRestaurant.dataStore = self
        present(addRestaurant, animated: true)
        tableView.reloadData()
    }
    
    private func delete(restaurant: Restaurant) {
        if let index = restaurants.firstIndex(where: { $0.name == restaurant.name }) {
            restaurants.remove(at: index)
            var snapshot = dataSource.snapshot()
            snapshot.deleteItems([restaurant])
            dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

// MARK: - Our Style and Layout
extension RestaurantViewController {
    
    private func style() {
        view.backgroundColor = .systemBackground
        title = "Les bons plans"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewRestaurant))
        navigationItem.rightBarButtonItem = addButton
        addButton.tintColor = .label
        
        view.addSubview(tableView)
        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.frame     = view.bounds
        tableView.estimatedRowHeight = 140.0
        tableView.rowHeight = UITableView.automaticDimension
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
                
                cell.selectionStyle = .none
                cell.set(restaurant: restaurant)
                cell.favoriteImageView.isHidden = restaurant.isFavorite ? false : true
                
                return cell
            }
        )
        
        return dataSource
    }
}

// MARK: - UITableViewDelegate
extension RestaurantViewController: UITableViewDelegate {
    
    // MARK: - didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let info = restaurants[indexPath.row]
        let detailVC = RestaurantDetailVC()
        
        let heartImage = info.isFavorite ? "heart.fill" : "heart"
        
        detailVC.heartButton.tintColor = info.isFavorite ? .systemYellow : .white
        detailVC.heartButton.setImage(UIImage(systemName: heartImage), for: .normal)
        
        detailVC.restaurant = info
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - trailingSwipeActionsConfigurationForRowAt
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if searchController.isActive {
            return UISwipeActionsConfiguration()
        }
        
        /// Get the selected restaurant
        guard let restaurant = self.dataSource.itemIdentifier(for: indexPath) else {
            return UISwipeActionsConfiguration()
        }
        
        /// Delete action
        let deleteAction = UIContextualAction(style: .destructive, title: "Supprimer") { [weak self] (_, _, completionHandler) in
            if let restaurant = self?.dataSource.itemIdentifier(for: indexPath) {
                
                self?.container?.mainContext.delete(restaurant)
                
                if let index = self?.restaurants.firstIndex(where: { $0.name == restaurant.name }) {
                    self?.restaurants.remove(at: index)
                }
                self?.updateSnapshot(animatingChange: true)
            }
            
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = .systemRed
        deleteAction.image = UIImage(systemName: "trash")
        
        /// Share action
        let shareAction = UIContextualAction(style: .normal, title: "Partager") {
            (action, sourceView, completionHandler) in
            
            let defaultText = "Je viens de m'enregistrer chez " + restaurant.name
            
            let activityController: UIActivityViewController
            
            activityController = UIActivityViewController(activityItems: [defaultText, restaurant.image], applicationActivities: nil)
            
            if let popoverController = activityController.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath) {
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                }
            }
            
            self.present(activityController, animated: true, completion: nil)
            completionHandler(true)
        }
        
        shareAction.backgroundColor = UIColor.systemOrange
        shareAction.image = UIImage(systemName: "square.and.arrow.up")
        
        /// Configure both action as swipe action
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        
        return swipeConfiguration
    }
    
    // MARK: - leadingSwipeActionsConfigurationForRowAt
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        /// Get the selected restaurant
        guard self.dataSource.itemIdentifier(for: indexPath) != nil else {
            return UISwipeActionsConfiguration()
        }
        
        /// Mark as favorite action
        let favoriteAction = UIContextualAction(style: .destructive, title: "") { (action, sourceView, completionHandler) in
            
            let cell = tableView.cellForRow(at: indexPath) as! RestaurantCell
            
            
            cell.favoriteImageView.isHidden = self.restaurants[indexPath.row].isFavorite
            
            self.restaurants[indexPath.row].isFavorite = self.restaurants[indexPath.row].isFavorite ? false : true
            
            /// Call completion handler to dismiss the action button
            completionHandler(true)
        }
        
        /// Configure swipe action
        favoriteAction.backgroundColor = UIColor.systemYellow
        favoriteAction.image = UIImage(systemName: self.restaurants[indexPath.row].isFavorite ? "heart.slash.fill" : "heart.fill")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [favoriteAction])
        
        return swipeConfiguration
    }
    
    // MARK: - willDisplay
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row < restaurantShown.count else {
                    return
                }
        
        if restaurantShown[indexPath.row] {
            return
        }
        
        /// Indicate the post has been displayed, so the animation won't be displayed again
        restaurantShown[indexPath.row] = true
        
        /// Define the initial state (Before the animation)
        let leadingAnimation = CATransform3DTranslate(CATransform3DIdentity, -500, 0, 0 )
        cell.layer.transform = leadingAnimation
        
        /// Define the final state (After the animation)
        UIView.animate(withDuration: 0.2, delay: TimeInterval(indexPath.row) * 0.1, options: .curveEaseOut, animations: {
            cell.layer.transform = CATransform3DIdentity
        }, completion: nil)
    }
}

extension RestaurantViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
    
        fetchRestaurantData(searchText: searchText)
    }
}
