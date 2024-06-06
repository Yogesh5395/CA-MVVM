//
//  ProductServiceImpl.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 14/12/23.
//

import Foundation
import Combine

class ProductServiceImpl: ProductService {
    
    let apiManager: NetworkManager
    
    init(apiManager: NetworkManager) {
        self.apiManager = apiManager
    }

    func fetch() -> Future<[Product], DataError> {
        return apiManager.requestItems(modelType: [Product].self, type: ProductEndPointType.products)
    }
}
