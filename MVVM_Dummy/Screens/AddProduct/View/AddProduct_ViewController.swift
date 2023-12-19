//
//  AddProduct_ViewController.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 19/12/23.
//

import UIKit

class AddProduct_ViewController: UISearchController {
    
    var viewModel: AddProductViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .red
        configuration()
    }
    
    func configuration() {
        let parameter = AddProduct(title: "My School")
        
        
        let apiManager            = APIManager() // Common API class
        let serviceImplementation = AddProductServiceImpl(apiManager: apiManager, product: parameter)
        
        let persistentStorageObj  = PersistentStorage() // Common Core Data class
        let productDataManager    = ProductDataManager(persistentStorageObj: persistentStorageObj)
        
        let addProductRepository = AddProductRepository(addProductService: serviceImplementation, productDatamanager: productDataManager)
        
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
            case .dataLoad: break
            
            case .error(let error):
                print(error!)
            case .none:
                print("nothing")
            }
            
        }
    }
}
