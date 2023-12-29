//
//  DeletedProducts_ViewController + btnAction.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 28/12/23.
//

import Foundation
import UIKit

extension DeletedProducts_ViewController {
    
    @objc func cellFavBtnTapped(sender: UIButton) {
        
        let buttonIndex = sender.tag
        if let product = self.viewModel?.deletedProductsVM[sender.tag] {
            if product.isDeleted_ {
                if let image = UIImage(systemName: "heart.fill")?.withTintColor(.gray, renderingMode: .alwaysOriginal) {
                    sender.setImage(image, for: .normal)
                }
                
                product.isDeleted_ = false
                self.viewModel?.updateProductFavouriteDeleteStatus(forID: product.id, toNewStatus: false)
                self.viewModel?.nonDeletedProductsVM.insert(product, at: 0)
                self.viewModel?.filteredProductsVM.insert(product, at: 0)
                self.viewModel?.deletedProductsVM.remove(at: sender.tag)
                self.viewModel?.deletedFavFilterProductsVM.remove(at: sender.tag)
                
                let indexPath = IndexPath(row: buttonIndex, section: 1)
                self.tableView.reloadData()
                return
            }
        }
    }
}
