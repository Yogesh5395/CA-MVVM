//
//  AddProductRepository.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 19/12/23.
//

import Foundation

class AddProductRepository {
    
    let addProductService: AddProductService
    let productDatamanager: ProductDataManager
    let productViewModel: ProductViewModel
    
    init(addProductService: AddProductService, productDatamanager: ProductDataManager, productViewModel: ProductViewModel) {
        self.addProductService  = addProductService
        self.productDatamanager = productDatamanager
        self.productViewModel   = productViewModel
    }
    
    func uploadProduct(completion: @escaping (Result<Product, DataError>) -> Void) {
        
        addProductService.uploadProduct { result in
            switch result {
            case .success(let product):
                productCount += 1
                let modifProduct = Product(id: Int16(productCount), image: "", title: product.title, category: "hardcore category", price: 0.00, rating: Rate(rate: 0.00, count: 00), description: "hardcore description", favourite: false, isDeleted_: false)
                
                let productsVM = SingleProductViewModel(product: modifProduct)
                self.productDatamanager.inserData(record: productsVM)
                self.productViewModel.productsVM.append(productsVM)
                
                completion(.success(modifProduct))
                
//                if let latestProduct = self.productDatamanager.fetchTopProduct() {
//                    completion(.success(latestProduct))
//                }else {
//                    completion(.success(modifProduct))
//                }
                
            case .failure(let error):
               print(error)
            completion(.failure(error))
            }
        }
        
    }
}
