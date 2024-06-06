//
//  ProductRepository.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 13/12/23.
//

import Foundation
import Combine

class ProductRepository {
    
    private var productServiceImplementation: ProductService
    private var productDataManager: ProductDataManager
    
    private var cancellables = Set<AnyCancellable>()
    
    init(productServiceImplementation: ProductService, productDataManager: ProductDataManager) {
        self.productServiceImplementation = productServiceImplementation
        self.productDataManager = productDataManager
    }
    
    func fetch() -> Future<[Product], DataError> {
        return Future { promise in
            if let products = self.productDataManager.fetchProducts(), !products.isEmpty {
                promise(.success(products))
            } else {
                self.callAPI()
                    .sink(receiveCompletion: { completion in
                        if case .failure(let error) = completion {
                            promise(.failure(error))
                        }
                    }, receiveValue: { products in
                        promise(.success(products))
                    })
                    .store(in: &self.cancellables)
            }
        }
    }
    
    private func callAPI() -> Future<[Product], DataError> {
        return Future { promise in
            self.productServiceImplementation.fetch()
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        promise(.failure(error))
                    }
                }, receiveValue: { products in
                    let productsVM: [SingleProductViewModel] = products.map { SingleProductViewModel(product: $0) }
                    
                    DispatchQueue.global(qos: .background).async {
                        for record in productsVM {
                            self.productDataManager.insertData(record: record)
                        }
                    }
                    promise(.success(products))
                })
                .store(in: &self.cancellables)
        }
    }
    
    func updateProductFavouriteStatus(forID id: Int16, toNewStatus newStatus: Bool) {
        productDataManager.updateProductFavouriteStatus(forID: id, toNewStatus: newStatus)
    }
    
    func updateProductFavouriteDeleteStatus(forID id: Int16, toNewStatus newStatus: Bool) {
        productDataManager.updateProductFavouriteDeleteStatus(forID: id, toNewStatus: newStatus)
    }
    
    func deleteProduct(forID id: Int16) -> Bool {
        return productDataManager.deleteProduct(forID: id)
    }
}
