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
    
    init(addProductService: AddProductService, productDatamanager: ProductDataManager) {
        self.addProductService = addProductService
        self.productDatamanager = productDatamanager
    }
    
    func uploadProduct(completion: @escaping (Result<Bool, DataError>) -> Void) {
        
        addProductService.uploadProduct { result in
            switch result {
            case .success(let product):
                
                let modifProduct = Product(id: 0, image: "", title: product.title, category: "hardcore category", price: 0.00, rating: Rate(rate: 0.00, count: 00), description: "hardcore description")
                
                let productsVM = SingleProductViewModel(product: modifProduct)
                self.productDatamanager.inserData(record: productsVM)
                
                completion(.success(true))
            case .failure(let error):
               print(error)
            completion(.failure(error))
            }
        }
        
    }
}
