//
//  ProductList_ViewController.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 08/12/23.
//

import UIKit
import Combine

class ProductList_ViewController: ChildViewController {
    
    @IBOutlet weak var bottomView: UIView!
    
    var viewModel: ProductViewModel?
    var cancellables = Set<AnyCancellable>()
    override var isEditing: Bool {
        didSet {
            // Your custom code for handling changes in editing state
            childTableViewController.tableView.setEditing(isEditing, animated: true)
            // Any additional logic you want to execute when editing mode changes
        }
    }
    
    var isSearchActive: Bool = false
    
    var selectedSegmentIndex: Int = 0
    
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
        filterFavProducts()
        self.childTableViewController.tableView.reloadData()
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
            
            viewModel?.$filteredProductsVM
                .receive(on:DispatchQueue.main)
                .sink(receiveValue: { [weak self] _ in
                    self?.childTableViewController.tableView.reloadData()
                })
                .store(in: &cancellables)
            
            viewModel?.eventHandlerSubject
                .receive(on: DispatchQueue.main)
                .sink { event in
                    
                    switch event {
                    case .loading:
                        print("product loading ...")
                    case .stopLoading:
                        print("loading completed ...")
                    case .dataLoad:
                        print("dataLoad dataLoad ...")
                    case .error(let error):
                        print(error!)
                    }
                }
                .store(in: &cancellables)
        }
    
    override func segmentChanged(_ sender: UISegmentedControl) {
        // Handle the segment change
        switch sender.selectedSegmentIndex {
        case 0:
            selectedSegmentIndex = 0
            if let productsVM = self.viewModel?.filterOutDeletedProducts() {
                viewModel?.filteredProductsVM = productsVM
//                self.childTableViewController.tableView.reloadData()// using viewModel?.$filteredProductsVM to update tableview
            }
        case 1:
            selectedSegmentIndex = 1
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
