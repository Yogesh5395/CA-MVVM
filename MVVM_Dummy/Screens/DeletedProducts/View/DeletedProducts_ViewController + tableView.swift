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
        return viewModel?.filterDeletedProducts().count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellId_and_Nib_ProductList_ViewController.ProductCell, for: indexPath) as! ProductCell
        
        cell.favouriteBtn.tag = indexPath.row
        cell.favouriteBtn.addTarget(self, action: #selector(cellFavBtnTapped(sender:)), for: .touchUpInside)
        
        cell.productVM = viewModel?.deletedProductsVM[indexPath.row]
        
        return cell
    }
}
