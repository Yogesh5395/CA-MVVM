//
//  DeletedProducts_ViewController + tableView.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 28/12/23.
//

import Foundation
import UIKit

extension DeletedProducts_ViewController {
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel?.deletedFavFilterProductsVM.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellId_and_Nib_ProductList_ViewController.ProductCell, for: indexPath) as! ProductCell
        
        cell.favouriteBtn.tag = indexPath.row
        cell.favouriteBtn.addTarget(self, action: #selector(cellFavBtnTapped(sender:)), for: .touchUpInside)
        
        cell.productVM = viewModel?.deletedFavFilterProductsVM[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Swipe to delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete { // Swipe delete
            if let product = self.viewModel?.deletedFavFilterProductsVM[indexPath.row] {
                if let status = self.viewModel?.deleteProduct(forID: product.id), status {
                    product.isDeleted_ = false
                    self.viewModel?.deletedProductsVM.remove(at: indexPath.row)
                    self.viewModel?.deletedFavFilterProductsVM.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
    }
}
