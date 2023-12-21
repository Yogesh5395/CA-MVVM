//
//  ProductList_ViewController + btnAction.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 21/12/23.
//

import Foundation
import UIKit

extension ProductList_ViewController {
    
    @IBAction func favBtnTapped(_ sender: Any) {
        
    
    }
    
    func filterFavProducts() {
        if let productsVM = self.viewModel?.productsVM {
            viewModel?.filteredProductsVM = productsVM.filter { product in
                return product.favourite
            }
        }
        self.childTableViewController.tableView.reloadData()
    }
    
    @objc func cellFavBtnTapped(sender: UIButton) {
    
        if let product = self.viewModel?.productsVM[sender.tag] {
            product.favourite = !product.favourite
            
            if product.favourite {
                if let image = UIImage(systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal) {
                    sender.setImage(image, for: .normal)
                }
            }else{
                if let image = UIImage(systemName: "heart.fill")?.withTintColor(.gray, renderingMode: .alwaysOriginal) {
                    sender.setImage(image, for: .normal)
                }
            }
            
            self.viewModel?.updateProductFavouriteStatus(forID: product.id, toNewStatus: product.favourite)
        }
    }
    
    @IBAction func deletebtnTapped(_ sender: Any) {
        
        if let selectedRows = self.childTableViewController.tableView.indexPathsForSelectedRows {
            // Reverse sort the indices so that we remove items from the end first
            let sortedIndices = selectedRows.sorted { $0.row > $1.row }
            for indexPath in sortedIndices {
                self.viewModel?.productsVM.remove(at: indexPath.row)
                self.viewModel?.filteredProductsVM.remove(at: indexPath.row)
            }
            self.childTableViewController.tableView.deleteRows(at: selectedRows, with: .automatic)
            editTapped()
        }
    }
}
