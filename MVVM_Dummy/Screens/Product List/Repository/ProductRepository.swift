//
//  ProductRepository.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 13/12/23.
//

import Foundation

class ProductRepository {
    
    var ProductServiceImplementation: ProductService
    
    var eventHandler: ((_ event:Event) -> Void)? // Data Binding Closure
    
    init(ProductServiceImplementation: ProductService) {
        self.ProductServiceImplementation = ProductServiceImplementation
    }
    
    func fetch(completion: @escaping(Result<[Product], DataError>) -> Void) {
        ProductServiceImplementation.fetch(completion: completion)
    }
    
}
