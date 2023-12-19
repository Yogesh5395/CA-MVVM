//
//  ProductList_ViewController.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 08/12/23.
//

import UIKit

class ProductList_ViewController: ChildViewController {
    
    var viewModel: ProductViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let documentDirectoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        debugPrint(documentDirectoryPath[0])

        
        childTableViewController.tableView.register(UINib(nibName: CellId_and_Nib_ProductList_ViewController.ProductCell, bundle: nil), forCellReuseIdentifier: CellId_and_Nib_ProductList_ViewController.ProductCell)
        
        configuration()
    }
    
    func configuration(){
        
        let apiManager            = APIManager() // Common API class
        let serviceImplementation = ProductServiceImpl(apiManager: apiManager)
        
        let persistentStorageObj  = PersistentStorage() // Common Core Data class
        let productDataManager    = ProductDataManager(persistentStorageObj: persistentStorageObj)
        
        let productRepository = ProductRepository(productServiceImplementation: serviceImplementation, productDataManager: productDataManager)
        
        let productUseCase = ProductUseCase(repository: productRepository)
        viewModel          = ProductViewModel(product: productUseCase)
        
        obsereEvent()
        viewModel?.fetchProductList()
    }
    
    // Data binding event observe karega - communication
    func obsereEvent() {
        
        viewModel?.eventHandler = { [weak self] event in
            guard let self else {return}
            
            switch event {
            case .loading:
                print("product loading ...")
            case .stopLoading:
                print("loading completed ...")
            case .dataLoad:
                DispatchQueue.main.async {
                    if let products = self.viewModel?.productsVM{
                        self.viewModel?.filteredProductsVM =  products
                        self.childTableViewController.tableView.reloadData()
                    }
                }
            case .error(let error):
                print(error!)
            }
            
        }
    }
}
