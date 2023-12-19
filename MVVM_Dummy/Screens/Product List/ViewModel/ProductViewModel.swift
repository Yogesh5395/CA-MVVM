//
//  ProductViewModel.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 08/12/23.
//

import Foundation

enum Event {
    
    case loading
    case stopLoading
    case dataLoad
    case error(Error?)
}

final class ProductViewModel {
    
    var productsVM:[SingleProductViewModel] = []
    var filteredProductsVM: [SingleProductViewModel] = []
    
    var eventHandler: ((_ event:Event) -> Void)? // Data Binding Closure
    
    private var product: ProductUseCase
    init(product: ProductUseCase) {
        self.product = product
    }
    
    func fetchProductList() {
        self.eventHandler?(.loading)
        self.product.fetch() { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let products):
                self.productsVM = products.map{SingleProductViewModel(product: $0)}
                self.eventHandler?(.dataLoad)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
}

