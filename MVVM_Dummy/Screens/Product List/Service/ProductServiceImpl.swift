//
//  ProductServiceImpl.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 14/12/23.
//

import Foundation

class ProductServiceImpl: ProductService {
    
    let apiManager: APIManager
    
    init(apiManager: APIManager) {
        self.apiManager = apiManager
    }
    
    func fetch(completion: @escaping(Result<[Product], DataError>) -> Void) {
        self.apiManager.request(modelType: [Product].self, type: ProductEndPointType.products, completion: completion)
    }
}
