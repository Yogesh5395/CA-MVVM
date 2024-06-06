//
//  AddProductServiceImpl.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 19/12/23.
//

import Foundation
import Combine

class AddProductServiceImpl: AddProductService {
    let apiManager: APIManager
    let product: AddProduct
    
    init(apiManager: APIManager, product: AddProduct) {
        self.apiManager = apiManager
        self.product = product
    }
    
    func uploadProduct() -> Future<AddProduct, DataError> {
        return self.apiManager.requestItems(modelType: AddProduct.self, type: ProductEndPointType.addProduct(self.product))
    }
}
