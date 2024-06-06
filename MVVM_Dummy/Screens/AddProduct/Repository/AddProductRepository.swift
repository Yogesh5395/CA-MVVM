//
//  AddProductRepository.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 19/12/23.
//

import Foundation
import Combine

class AddProductRepository {
    
    let addProductService: AddProductService
    let productDatamanager: ProductDataManager
    let productViewModel: ProductViewModel
    
    private var cancellables = Set<AnyCancellable>()
    
    init(addProductService: AddProductService, productDatamanager: ProductDataManager, productViewModel: ProductViewModel) {
        self.addProductService  = addProductService
        self.productDatamanager = productDatamanager
        self.productViewModel   = productViewModel
    }
    
    func uploadProduct() -> Future<Product, DataError> {
        return Future { [self] promise in
            addProductService.uploadProduct()
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    if case .failure(let error) = completion {
                    print(error)
                     promise(.failure(error))
                    }
                } receiveValue: { product in
                    productCount += 1
                    let modifProduct = Product(id: Int(Int16(productCount)), image: "", title: product.title, category: "hardcore category", price: 0.00, rating: Rate(rate: 0.00, count: 00), description: "hardcore description", favourite: false, isDeleted_: false)
                    
                    let productsVM = SingleProductViewModel(product: modifProduct)
                    self.productDatamanager.insertData(record: productsVM)
                    self.productViewModel.productsVM.append(productsVM)
                    
                    promise(.success(modifProduct))
                }
                .store(in: &self.cancellables)
        }
    }
}
