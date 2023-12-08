//
//  ProductList_ViewController.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 08/12/23.
//

import UIKit

class ProductList_ViewController: ChildViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        childTableViewController.tableView.register(UINib(nibName: CellId_and_Nib_ProductList_ViewController.ProductTableViewCell, bundle: nil), forCellReuseIdentifier: CellId_and_Nib_ProductList_ViewController.ProductTableViewCell)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellId_and_Nib_ProductList_ViewController.ProductTableViewCell, for: indexPath) as! ProductTableViewCell
        return cell
    }
    
}
