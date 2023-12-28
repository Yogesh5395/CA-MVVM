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
    
    // Only Favourite Products
    func filterFavProducts() {
//        if let productsVM = self.viewModel?.filterOutDeletedProducts(){
//            viewModel?.filteredProductsVM = productsVM.filter { product in
//                return product.favourite
//            }
//        }
//
//        if let productsVM = self.viewModel?.filterDeletedProducts(){
//            viewModel?.deletedProductsVM = productsVM.filter { product in
//                return product.isDeleted_
//            }
//        }
        
        self.childTableViewController.tableView.reloadData()
    }
    
    @objc func cellFavBtnTapped(sender: UIButton) {
    
        if selectedSegmentIndex == 1 {
            let buttonIndex = sender.tag
            if let product = self.viewModel?.deletedProductsVM[sender.tag] {
                if product.isDeleted_ {
                    if let image = UIImage(systemName: "heart.fill")?.withTintColor(.gray, renderingMode: .alwaysOriginal) {
                        sender.setImage(image, for: .normal)
                    }
                    
                    product.isDeleted_ = false
                    self.viewModel?.updateProductFavouriteDeleteStatus(forID: product.id, toNewStatus: false)
                    self.viewModel?.nonDeletedProductsVM.insert(product, at: 0)
                    
                    self.viewModel?.deletedProductsVM.remove(at: sender.tag)
                    
                    let indexPath = IndexPath(row: buttonIndex, section: 1)
                    self.childTableViewController.tableView.reloadData()//deleteRows(at: [indexPath], with: .fade)
                    return
                }
            }
        }
        
        if let product = self.viewModel?.nonDeletedProductsVM[sender.tag] {
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
