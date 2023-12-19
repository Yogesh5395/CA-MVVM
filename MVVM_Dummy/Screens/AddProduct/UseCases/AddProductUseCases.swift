//
//  AddProductUseCases.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 19/12/23.
//

import Foundation

class AddProductUseCases {
    
    let addProductRepository: AddProductRepository
    
    init(addProductRepository: AddProductRepository) {
        self.addProductRepository = addProductRepository
    }
    
    func uploadProduct(completion: @escaping (Result<Bool, DataError>) -> Void) {
        addProductRepository.uploadProduct(completion: completion)
    }
}
