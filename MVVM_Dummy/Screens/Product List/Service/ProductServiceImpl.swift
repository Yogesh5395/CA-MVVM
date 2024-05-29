//
//  ProductServiceImpl.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 14/12/23.
//

import Foundation

class ProductServiceImpl: ProductService {
    
    let apiManager: NetworkManager
    
    init(apiManager: NetworkManager) {
        self.apiManager = apiManager
    }
    
    func fetch(completion: @escaping(Result<[Product], DataError>) -> Void) {
        self.apiManager.requestItems(modelType: [Product].self, type: ProductEndPointType.products, completion: completion)
    }
}
