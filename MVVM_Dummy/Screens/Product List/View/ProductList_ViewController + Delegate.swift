//
//  ProductList_ViewController + Delegate.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 21/12/23.
//

import Foundation

extension ProductList_ViewController: addProduct {
    func productUploaded(productVM: SingleProductViewModel) {
        DispatchQueue.main.async {
            
            self.viewModel?.productsVM.insert(productVM, at: 0)
            if let products = self.viewModel?.productsVM{
                self.viewModel?.filteredProductsVM =  products
                self.childTableViewController.tableView.reloadData()
            }
        }
    }
}
