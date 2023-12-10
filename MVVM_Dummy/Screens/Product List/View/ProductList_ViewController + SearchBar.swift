//
//  ProductList_ViewController + SearchBar.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 10/12/23.
//

import Foundation
import UIKit

extension ProductList_ViewController {
    
    override func updateSearchResults(for searchController: UISearchController) {
        
        let searchText = searchController.searchBar.text
        print("searchText: ",searchText)
        
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            viewModel.filteredProducts = viewModel.products
            self.childTableViewController.tableView.reloadData()
            return
        }
        
        viewModel.filteredProducts = viewModel.products.filter { product in
            return product.title.lowercased().contains(searchText.lowercased())
        }
        
        self.childTableViewController.tableView.reloadData()
    }
    
}
