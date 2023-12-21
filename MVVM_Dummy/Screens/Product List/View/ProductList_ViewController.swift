//
//  ProductList_ViewController.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 08/12/23.
//

import UIKit

class ProductList_ViewController: ChildViewController {
    
    @IBOutlet weak var bottomView: UIView!
    
    var viewModel: ProductViewModel?
    
    override var isEditing: Bool {
        didSet {
            // Your custom code for handling changes in editing state
            childTableViewController.tableView.setEditing(isEditing, animated: true)
            // Any additional logic you want to execute when editing mode changes
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let documentDirectoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        debugPrint(documentDirectoryPath[0])
        
        childTableViewController.tableView.register(UINib(nibName: CellId_and_Nib_ProductList_ViewController.ProductCell, bundle: nil), forCellReuseIdentifier: CellId_and_Nib_ProductList_ViewController.ProductCell)
        
        self.view.bringSubviewToFront(self.bottomView)
        self.bottomView.isHidden = true
        configuration()
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    func configuration(){
        
        let apiManager            = APIManager() // Common API class
        let serviceImplementation = ProductServiceImpl(apiManager: apiManager)
        
        let persistentStorageObj  = PersistentStorage() // Common Core Data class
        let productDataManager    = ProductDataManager(persistentStorageObj: persistentStorageObj)
        
        let productRepository = ProductRepository(productServiceImplementation: serviceImplementation, productDataManager: productDataManager)
        
        let productUseCase = ProductUseCase(repository: productRepository)
        viewModel          = ProductViewModel(productUseCase: productUseCase)
        
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
                        productCount = products.count // Set product count globally
                        self.viewModel?.filteredProductsVM =  products
                        self.childTableViewController.tableView.reloadData()
                    }
                }
            case .error(let error):
                print(error!)
            }
            
        }
    }
    
    override func segmentChanged(_ sender: UISegmentedControl) {
        // Handle the segment change
        switch sender.selectedSegmentIndex {
        case 0:
            if let productsVM = self.viewModel?.productsVM {
                viewModel?.filteredProductsVM = productsVM
                self.childTableViewController.tableView.reloadData()
            }
        case 1:
            filterFavProducts()
        default:
            break
        }
    }
    
    override func editTapped() {
        
        self.bottomView.isHidden = isEditing
        isEditing = !isEditing
        super.setEditing(isEditing, animated: true)
        self.childTableViewController.setEditing(isEditing, animated: true)
        self.childTableViewController.tableView.allowsMultipleSelectionDuringEditing = isEditing
        
        if isEditing {
            // Hide the tab bar if in editing mode
            tabBarController?.tabBar.isHidden = true
        } else {
            // Show the tab bar when not in editing mode
            tabBarController?.tabBar.isHidden = false
        }
    }
}
