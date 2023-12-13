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
            viewModel.filteredProductsVM = self.viewModel.productsVM
            self.childTableViewController.tableView.reloadData()
            return
        }
        
        viewModel.filteredProductsVM = viewModel.productsVM.filter { product in
            return product.title.lowercased().contains(searchText.lowercased())
        }
        
        self.childTableViewController.tableView.reloadData()
    }
    
}
