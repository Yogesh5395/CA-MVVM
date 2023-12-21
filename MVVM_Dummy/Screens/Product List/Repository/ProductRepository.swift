//
//  ProductRepository.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 13/12/23.
//

import Foundation

class ProductRepository {
    
    private var productServiceImplementation: ProductService
    private var productDataManager:ProductDataManager
    
    init(productServiceImplementation: ProductService, productDataManager: ProductDataManager) {
        self.productServiceImplementation = productServiceImplementation
        self.productDataManager = productDataManager
    }
    
    func fetch(completion: @escaping(Result<[Product], DataError>) -> Void) {
        
        // Checking, fetch the data from API or DB
        if let products = productDataManager.fetchProducts() {
            if products.count == 0 {
                callAPI(completion: completion)
            }else {
                completion(.success(products))
            }
        }else {
            callAPI(completion: completion)
        }
    }
    
    func callAPI(completion: @escaping(Result<[Product], DataError>) -> Void) {
        productServiceImplementation.fetch { result in
            switch result {
            case .success(let products):
                let productsVM: [SingleProductViewModel] = products.map{SingleProductViewModel(product: $0)}
                
                DispatchQueue.global(qos: .background).async {
                    for record in productsVM {
                        self.productDataManager.inserData(record: record)
                    }
                }
                self.productServiceImplementation.fetch(completion: completion)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func updateProductFavouriteStatus(forID id: Int16, toNewStatus newStatus: Bool) {
        productDataManager.updateProductFavouriteStatus(forID: id, toNewStatus: newStatus)
    }
    
    func deleteProduct(forID id: Int16) -> Bool {
        self.productDataManager.deleteProduct(forID: id)
    }
}


