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
        Restaurant(name: "L'art du café", type: "Salon de Café et thé", location: "10 Allée François Mitterrand, 67400 Illkirch-Graffenstaden", image: "cafedeadend", isFavorite: false, phone: "03 88 43 06 77", description: "Café/Snack agréable pour la pause déjeuner. Carte simple, proposition de plat du jour. Si les plats ne sortent pas particulièrement de l'ordinaire, ils sont bien réalisés, avec des ingrédients frais et le plaisir est là."),
        Restaurant(name: "Café Broglie", type: "Salon de Café", location: "1 Rue du Dôme, 67000 Strasbourg", image: "homei", isFavorite: false, phone: "03 88 32 08 08", description: "le Café Broglie se situe à quelques pas de l'Opéra et de la Cathédrale, c'est une étape incontournable et fait partie des lieux que les strasbourgeois fréquentes très souvent. Dans ce café brasserie, retrouvez une série de plats français composé par le chef de cuisine et son équipe. Tous les jours, découvrez également les suggestions sur ardoise. Pour finir venez déguster nos petits déjeuners."),
        Restaurant(name: "Au Fond de la Théière", type: "Maison du thé", location: "32 Grande Rue, 67000 Strasbourg", image: "teakha", isFavorite: false, phone: "09 55 39 16 73", description: "Salon de thé convivial avec une salle intérieure et une terrasse. Le salon vous propose des thés/cafés accompagnés et pâtisseries préparées par un grand chef étoilé, des sandwichs chauds ou froids et des salades."),
        Restaurant(name: "Le Café Monceau", type: "Salon de Café et thé", location: "154a Rte de Lyon, 67400 Illkirch-Graffenstaden", image: "cafeloisl", isFavorite: false, phone: "09 86 73 70 80", description: "Dans un cadre charmant et convivial et grâce à nos délicieux plats, nous convainquons nos clients dès leur première visite.  Le Café Monceau est un lieu de rencontre prisé pour le petit déjeuner, déjeuner ou l'apéro..."),
        Restaurant(name: "Le chasseur", type: "Restaurant", location: "70 Rte de Lyon, 67400 Illkirch-Graffenstaden", image: "petiteoyster", isFavorite: false, phone: "03 88 66 77 69", description: "La cuisine française créée par un chef grandiose est magnifique à cet endroit. N'oubliez pas d'apprécier des tartes cuites à la perfection à ce restaurant. Les gourmets remarquent qu'un gâteau aux fruits est savoureux ici. Un vin délicieux rendra votre repas plus savoureux et vous fera surement revenir. Sur la base des opinions des visiteurs, les serveurs offrent un café immense ici."),
        Restaurant(name: "Au vieux Strasbourg", type: "Restaurant", location: "5 Rue du Maroquin, 67000 Strasbourg", image: "forkee", isFavorite: false, phone: "03 88 32 41 89", description: "Restaurant à l'ambiance détendue doté de murs en lambris, servant des spécialités alsaciennes comme les spätzle et le foie gras."),
        Restaurant(name: "Pains WŒRLÉ", type: "Boulangerie", location: "10 Rue de la Division Leclerc, 67000 Strasbourg", image: "posatelier", isFavorite: false, phone: "03 88 15 19 30", description: "Baguettes, pâtisseries et friandises alsaciennes (comme les bretzels ou le kougelhopf) vendues dans une boulangerie centenaire."),
        Restaurant(name: "Boulangerie Beck", type: "Boulangerie", location: "267 Rte de Lyon, 67400 Illkirch-Graffenstaden", image: "bourkestreetbakery", isFavorite: false, phone: "03 88 66 12 99", description: "03 88 66 12 99"),
        Restaurant(name: "Schaal chocolatier", type: "Salon de café", location: "Rue du Pont-du-Péage, 67118 Geispolsheim", image: "haigh", isFavorite: false, phone: "03 88 55 04 00", description: "SCHAAL confectionne une offre de succulents chocolats au service de ses clients partenaires qu’il s’agisse de marques de gourmandises renommées ou d’artisans commerçants disposant de boutiques raffinées. Ses recettes originelles telles que le praliné à l’ancienne font notre renommée en France et à l’international."),
        Restaurant(name: "Au Hussard", type: "Salon de café", location: "30 Rue du Général Leclerc, 67540 Ostwald", image: "palomino", isFavorite: false, phone: "03 88 67 07 78", description: "La cuisine française est bien préparée à ce restaurant. Un café immense est ce qui peut vous faire revenir à Au Hussard - Chez Pino et Malou."),
        Restaurant(name: "La Hache", type: "Restaurant", location: "11 Rue de la Douane, 67000 Strasbourg", image: "upstate", isFavorite: false, phone: "03 88 32 34 32", description: "La Hache est un des plus vieux établissements de la ville, un bistro moderne à l’ambiance complice, un lieu vivant, gourmand et chaleureux. On y sert à table ou au comptoir une cuisine maison, authentique, originale et inspirée. La carte des vins n’est pas en reste et propose grands classiques et vraies trouvailles."),
        Restaurant(name: "Buffalo Grill", type: "Restauration rapide", location: "Rue de Lyon, N83, 67640 Fegersheim", image: "traif", isFavorite: false, phone: "03 88 59 06 09", description: "Chaîne de restaurants spécialisés en grillades et burgers, au décor de far west et à l’ambiance familiale."),
        Restaurant(name: "La Croix de Savoie", type: "Restaurant", location: "133 Rte de Lyon, 67400 Illkirch-Graffenstaden", image: "graham", isFavorite: false, phone: "03 88 66 65 66", description: "Ce restaurant au cadre rustique et boisé sert des spécialités savoyardes telles que fondues et raclettes."),
        Restaurant(name: "Café de l'Opéra", type: "Salon de café et thé", location: "19 Pl. Broglie, 67000 Strasbourg", image: "waffleandwolf", isFavorite: false, phone: "09 77 21 68 18", description: "Carte simple de viandes, pizzas ou salades dans une salle à la déco années 1930 ou sur la terrasse avec vue."),
        Restaurant(name: "Café Atlantico", type: "Boulangerie", location: "9A Quai des Pêcheurs, 67000 Strasbourg", image: "fiveleaves", isFavorite: false, phone: "03 88 35 77 81", description: "Péniche convertie en élégante brasserie prisée pour les classiques du petit-déjeuner et du brunch comme la brioche."),
        Restaurant(name: "Bella Vita", type: "Restaurant", location: "3 rue prechter 67000 Strasbourg", image: "confessional", isFavorite: false, phone: "03 88 96 88 10", description: "Après 15 ans d'ancienneté dans le milieu de la restauration et de la pizza, nous sommes ravis de vous accueillir dans notre restaurant la Bella Vita, où vous pourrez déguster d'excellentes pizzas mais aussi des tartes flambées faites maison, avec amour et passion."),
        Restaurant(name: "Del Arte", type: "Restaurant", location: "Centre Commercial Auchan, 6 Avenue de Strasbourg 67400, ILLKIRCH GRAFFENSTADEN", image: "barrafina", isFavorite: false, phone: "03 88 39 70 99", description: "Que ce soit en cuisine, en salle ou au sein de l’encadrement, nous vous proposons de vivre l’aventure d’une enseigne en croissance. "),
        Restaurant(name: "L'Impasto", type: "Restaurant", location: "154 Rte de Lyon, 67400 Illkirch-Graffenstaden", image: "donostia", isFavorite: false, phone: "03 88 40 78 35", description: "Pizza & panuozzo sur place et à emporter Pâte maison, farines bio, longue maturation. Sélection et respect des produits. Nous avons à coeur de vous proposer de l'artisanat de proximité"),
        Restaurant(name: "Ô Brocomagus", type: "Restaurant", location: "67170 Brumath", image: "royaloak", isFavorite: false, phone: "03 88 64 20 93", description: "Patisserie, salon de thé, restauration plat du jour et suggestions par la maison Bernhard en face de la nouvelle médiathèque cour du château à brumath."),
        Restaurant(name: "La Halle aux Blés", type: "Restaurant", location: "Pl. du Marché, 67210 Obernai", image: "cask", isFavorite: false, phone: "03 88 95 56 09", description: "Cuisine traditionnelle du terroir alsacien dans une ambiance de winstub typique au sein d'une bâtisse de 1553.")
    ]
    
    var restaurantIsFavorites       = Array(repeating: false, count: 21)
    lazy var restaurantShown        = [Bool](repeating: false, count: restaurants.count)
    let tableView                   = UITableView()
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let appearance = navigationController?.navigationBar.standardAppearance
        {
            appearance.backgroundColor = .systemBackground
            if let customFont = UIFont(name: "Nunito-Bold", size: 45.0) {
                appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!]
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!, .font: customFont]
            }
        }
        
        style()
        dataSource = setupDataSource()
        setupInitialSnapshot()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: false)
    }
}

// MARK: - Our Style and Layout
extension RestaurantVC {
    
    private func style() {
        view.backgroundColor = .systemBackground
        title = "Les bons plans"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        addButton.tintColor = .label
        
        view.addSubview(tableView)
        tableView.cellLayoutMarginsFollowReadableWidth = true
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
}

// MARK: - Our Action Button and Logic
extension RestaurantVC {
    
    private func setupInitialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Restaurant>()
        snapshot.appendSections([0])
        snapshot.appendItems(restaurants, toSection: 0)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    @objc func addButtonTapped() {
        let alert = UIAlertController(title: "Fonctionnalité non disponible", message: "Cette fonctionnalité n'est pas encore disponible.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    @objc func handleIsFavorite() {
        print("foo - OK")
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

// MARK: - UITableViewDelegate
extension RestaurantVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let info = restaurants[indexPath.row]
        let detailVC = RestaurantDetailVC()
        
        let heartImage = info.isFavorite ? "heart.fill" : "heart"
        detailVC.heartButton.tintColor = info.isFavorite ? .systemPink : .white
        detailVC.heartButton.setImage(UIImage(systemName: heartImage), for: .normal)
        detailVC.heartButton.addTarget(self, action: #selector(handleIsFavorite), for: .touchUpInside)
        
        detailVC.restaurant = info
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        /// Get the selected restaurant
        guard let restaurant = self.dataSource.itemIdentifier(for: indexPath) else {
            return UISwipeActionsConfiguration()
        }
        
        /// Delete action
        let deleteAction = UIContextualAction(style: .destructive, title: "Supprimer") { [weak self] (_, _, completionHandler) in
            self?.delete(restaurant: restaurant)
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = .systemRed
        deleteAction.image = UIImage(systemName: "trash")
        
        /// Share action
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if restaurantShown[indexPath.row] {
            return
        }
        
        /// Indicate the post has been displayed, so the animation won't be displayed again
        restaurantShown[indexPath.row] = true
        
        /// Define the initial state (Before the animation)
        let leadingAnimation = CATransform3DTranslate(CATransform3DIdentity, -500, 0, 0 )
        cell.layer.transform = leadingAnimation
        
        /// Define the final state (After the animation)
        UIView.animate(withDuration: 0.3, delay: TimeInterval(indexPath.row) * 0.1, options: .curveEaseInOut, animations: {
            cell.layer.transform = CATransform3DIdentity
        }, completion: nil)
    }
}

#Preview {
    let vc = RestaurantVC()
    return vc
}
