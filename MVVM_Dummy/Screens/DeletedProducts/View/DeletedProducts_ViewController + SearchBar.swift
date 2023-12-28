//
//  DeletedProducts_ViewController + SearchBar.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 28/12/23.
//

import Foundation
import UIKit

extension DeletedProducts_ViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        print("searchText: ",searchText)
        
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            
            if let productsVM = self.viewModel?.deletedProductsVM {
                viewModel?.filteredProductsVM = productsVM
                self.tableView.reloadData()
            }
            return
        }
        
        if let productsVM = self.viewModel?.deletedProductsVM {
            viewModel?.filteredProductsVM = productsVM.filter { product in
                return product.title.lowercased().contains(searchText.lowercased())
            }
        }
        
        self.tableView.reloadData()
    }
    
    // MARK: - UISearchControllerDelegate
    func didDismissSearchController(_ searchController: UISearchController) {
        // This method is called when the search controller is dismissed
        print("Search cancelled or completed")
        // Handle the search cancellation here
        
        if let productsVM = self.viewModel?.deletedProductsVM {
            viewModel?.filteredProductsVM = productsVM
        }
        
        self.tableView.reloadData()
    }
}
