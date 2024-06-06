//
//  AddProductUseCases.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 19/12/23.
//

import Foundation
import Combine

class AddProductUseCases {
    
    let addProductRepository: AddProductRepository
    
    init(addProductRepository: AddProductRepository) {
        self.addProductRepository = addProductRepository
    }
    
    func uploadProduct() -> Future<Product, DataError> {
        return addProductRepository.uploadProduct()
    }
}
