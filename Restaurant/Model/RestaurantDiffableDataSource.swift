//
//  RestaurantDiffableDataSource.swift
//  Restaurant
//
//  Created by olivier geiger on 25/03/2024.
//

import UIKit


class RestaurantDiffableDataSource: UITableViewDiffableDataSource<Int, Restaurant> {
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
    }
}
