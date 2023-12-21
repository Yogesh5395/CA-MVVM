//
//  ProductUseCase.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 13/12/23.
//

import Foundation

class ProductUseCase {
    
    var repository: ProductRepository
    
    init(repository: ProductRepository) {
        self.repository = repository
    }
    
    func fetch(completion: @escaping(Result<[Product], DataError>) -> Void) {
        repository.fetch(completion: completion)
    }
    
    func updateProductFavouriteStatus(forID id: Int16, toNewStatus newStatus: Bool) {
        repository.updateProductFavouriteStatus(forID: id, toNewStatus: newStatus)
    }
}
