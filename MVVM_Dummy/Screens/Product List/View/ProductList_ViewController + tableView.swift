//
//  ProductList_ViewController + tableView.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 10/12/23.
//

import Foundation
import UIKit

extension ProductList_ViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if selectedSegmentIndex == 1 && isSearchActive == false{
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearchActive && selectedSegmentIndex == 1{
            return viewModel?.deletedFavProductsVM.count ?? 0
        }else if isSearchActive && selectedSegmentIndex == 0 {
            return viewModel?.filteredProductsVM.count ?? 0
        }
        
        if selectedSegmentIndex == 1 {
            if section == 1 {
                return viewModel?.filterDeletedProducts().count ?? 0
            }else {
                
                if let productsVM = self.viewModel?.filterOutDeletedProducts(){
                    viewModel?.filteredProductsVM = productsVM.filter { product in
                        return product.favourite
                    }
                }
                
                return viewModel?.filteredProductsVM.count ?? 0
            }
        }
        
        if let products = self.viewModel?.filterOutDeletedProducts(){
            self.viewModel?.filteredProductsVM =  products
        }
        return viewModel?.filteredProductsVM.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellId_and_Nib_ProductList_ViewController.ProductCell, for: indexPath) as! ProductCell
        
        cell.favouriteBtn.tag = indexPath.row
        cell.favouriteBtn.addTarget(self, action: #selector(cellFavBtnTapped(sender:)), for: .touchUpInside)
        
        if isSearchActive && selectedSegmentIndex == 1{
            cell.productVM = viewModel?.deletedFavProductsVM[indexPath.row]
        }else {
            if indexPath.section == 0 {
                cell.productVM = viewModel?.filteredProductsVM[indexPath.row]
            }else {
                cell.productVM = viewModel?.deletedProductsVM[indexPath.row]
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Swipe to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete { // Swipe delete
            // Update your data source and delete the row
            
            if isSearchActive { // for search bar
                if let product = self.viewModel?.deletedFavProductsVM[indexPath.row] {
                    if product.favourite && !product.isDeleted_{ // Inside the ALL tab, temparay deleting the favourite product and updating the delete status
                        self.viewModel?.updateProductFavouriteDeleteStatus(forID: product.id, toNewStatus: product.favourite)
                        product.isDeleted_ = product.favourite
                        self.viewModel?.deletedFavProductsVM.remove(at: indexPath.row)
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    }else {  // Inside the ALL tab, permanant deleting the product which is not favourite
                        if let status = self.viewModel?.deleteProduct(forID: product.id), status {
                            product.isDeleted_ = true
                            self.viewModel?.deletedFavProductsVM.remove(at: indexPath.row)
                            tableView.deleteRows(at: [indexPath], with: .fade)
                        }
                    }
                }
                return
            }
            
            if selectedSegmentIndex == 0 { // Inside the ALL tab, 
                if let product = self.viewModel?.nonDeletedProductsVM[indexPath.row] {
                    if product.favourite { // Inside the ALL tab, temparay deleting the favourite product and updating the delete status
                        self.viewModel?.updateProductFavouriteDeleteStatus(forID: product.id, toNewStatus: product.favourite)
                        product.isDeleted_ = product.favourite
                        self.viewModel?.nonDeletedProductsVM.remove(at: indexPath.row)
                        self.viewModel?.filteredProductsVM.remove(at: indexPath.row)
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    }else {  // Inside the ALL tab, permanant deleting the product which is not favourite
                        if let status = self.viewModel?.deleteProduct(forID: product.id), status {
                            product.isDeleted_ = true
                            self.viewModel?.nonDeletedProductsVM.remove(at: indexPath.row)
                            self.viewModel?.filteredProductsVM.remove(at: indexPath.row)
                            tableView.deleteRows(at: [indexPath], with: .fade)
                        }
                    }
                }
            }else { // Inside the favourite tab
                if indexPath.section == 0 {
                    if let product = self.viewModel?.filteredProductsVM[indexPath.row] {
                        if product.favourite { // Inside the favourite tab, temparay deleting the favourite product and updating the delete status
                            self.viewModel?.updateProductFavouriteDeleteStatus(forID: product.id, toNewStatus: product.favourite)
                            product.isDeleted_ = product.favourite
                            self.viewModel?.filteredProductsVM.remove(at: indexPath.row)
                            tableView.deleteRows(at: [indexPath], with: .fade)
                        }
                    }
                }else { // Inside the Favourite tab,deleted product permanant deleting the product
                    if let product = self.viewModel?.deletedProductsVM[indexPath.row] {
                        if let status = self.viewModel?.deleteProduct(forID: product.id), status {
                            product.isDeleted_ = true
                            self.viewModel?.deletedProductsVM.remove(at: indexPath.row)
                            tableView.deleteRows(at: [indexPath], with: .fade)
                        }
                    }
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if selectedSegmentIndex == 1 {
            if section == 0 {
                return "Favourite Products"
            }else {
                
                if viewModel?.deletedProductsVM.count != 0 {
                    return "Deleted Favourite Products"
                }
            }
        }
        
        return ""
    }
}
