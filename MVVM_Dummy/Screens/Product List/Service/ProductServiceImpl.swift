//
//  ProductServiceImpl.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 14/12/23.
//

import Foundation

class ProductServiceImpl: ProductService {
    
    func fetch(completion: @escaping(Result<[Product], DataError>) -> Void) {
        APIManager.shared.request(modelType: [Product].self, type: ProductEndPointType.products, completion: completion)
    }
}
