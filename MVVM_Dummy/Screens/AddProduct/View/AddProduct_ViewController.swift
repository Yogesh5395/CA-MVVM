//
//  AddProduct_ViewController.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 19/12/23.
//

import UIKit

protocol addProduct {
    func productUploaded(productVM: SingleProductViewModel)
}

class AddProduct_ViewController: UISearchController {
    
    var viewModel: AddProductViewModel?
    var addProductDelegate: addProduct?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .red
        configuration()
    }
    
    func configuration() {
        let parameter = AddProduct(title: "Jai Shyam Sundar :)")
        
        let apiManager            = APIManager() // Common API class
        let serviceImplementation = AddProductServiceImpl(apiManager: apiManager, product: parameter)
        
        let persistentStorageObj  = PersistentStorage() // Common Core Data class
        let productDataManager    = ProductDataManager(persistentStorageObj: persistentStorageObj)
        
        let serviceImpl = ProductServiceImpl(apiManager: apiManager)
        let productRepository = ProductRepository(productServiceImplementation: serviceImpl, productDataManager: productDataManager)
        
        let productUseCase = ProductUseCase(repository: productRepository)
        
        let productViewModel = ProductViewModel(productUseCase: productUseCase)
        
        let addProductRepository = AddProductRepository(addProductService: serviceImplementation, productDatamanager: productDataManager, productViewModel: productViewModel)
        
        let addProductUseCase = AddProductUseCases(addProductRepository: addProductRepository)
        viewModel          = AddProductViewModel(addProductUseCases: addProductUseCase)
        
        obsereEvent()
        viewModel?.uploadProduct()
    }
    
    func uploadProduct() {
        
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
                if let productVM = viewModel?.productVM {
                    DispatchQueue.main.async {
                        self.addProductDelegate?.productUploaded(productVM: productVM)
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            case .error(let error):
                print(error!)
            case .none:
                print("nothing")
            }
            
        }
    }
}
