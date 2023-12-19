//
//  AddProductServiceImpl.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 19/12/23.
//

import Foundation

class AddProductServiceImpl: AddProductService {
    
    let apiManager: APIManager
    let product: AddProduct
    
    init(apiManager: APIManager, product: AddProduct) {
        self.apiManager = apiManager
        self.product = product
    }
    
    func uploadProduct(completion: @escaping (Result<AddProduct, DataError>) -> Void) {
        self.apiManager.requestItems(modelType: AddProduct.self, type: ProductEndPointType.addProduct(self.product), completion: completion)
    }
}
