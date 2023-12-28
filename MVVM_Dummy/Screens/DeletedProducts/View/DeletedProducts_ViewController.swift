//
//  DeletedProducts_ViewController.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 28/12/23.
//

import UIKit

class DeletedProducts_ViewController: UITableViewController {

    var viewModel: ProductViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItems(leftButtonTitle: "", rightButtonTitle: "", logoImageName: ImageName.logoImageName, showLogoImage: false, backgroundColor: .white)
        
        self.navigationItem.title = "Deleted Products"
        
        self.tableView.register(UINib(nibName: CellId_and_Nib_ProductList_ViewController.ProductCell, bundle: nil), forCellReuseIdentifier: CellId_and_Nib_ProductList_ViewController.ProductCell)
    }

}
