//
//  ProductList_ViewController + SearchBar.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 10/12/23.
//

import Foundation
import UIKit

extension ProductList_ViewController {
    // MARK: - UISearchControllerDelegate
    
    override func updateSearchResults(for searchController: UISearchController) {
        isSearchActive = true
        
        let searchText = searchController.searchBar.text
        print("searchText: ",searchText)
        
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            
            if let productsVM = self.viewModel?.filterOutDeletedProducts() {
                viewModel?.filteredProductsVM = productsVM
                self.childTableViewController.tableView.reloadData()
            }
            return
        }
        
        if selectedSegmentIndex == 0 {
            if let productsVM = self.viewModel?.filterOutDeletedProducts() {
                viewModel?.filteredProductsVM = productsVM.filter { product in
                    return product.title.lowercased().contains(searchText.lowercased())
                }
            }
        }else {
            if let productsVM = self.viewModel?.filterDeletedandFavouriteProducts() {
                viewModel?.deletedFavProductsVM = productsVM.filter { product in
                    return product.title.lowercased().contains(searchText.lowercased())
                }
            }
        }
        
        self.childTableViewController.tableView.reloadData()
    }
    
    override func didDismissSearchController(_ searchController: UISearchController) {
        // Handle the cancellation here
        print("Search cancelled")
        isSearchActive = false
        
//        if let productsVM = self.viewModel?.filterOutDeletedProducts() {
//            viewModel?.filteredProductsVM = productsVM
//        }
        
        self.childTableViewController.tableView.reloadData()
    }
}
