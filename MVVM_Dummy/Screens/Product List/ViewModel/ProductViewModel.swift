//
//  ProductViewModel.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 08/12/23.
//

import Foundation

class ProductViewModel {
    
    var productsVM:[SingleProductViewModel] = []
    var filteredProductsVM: [SingleProductViewModel] = []
    
    var eventHandler: ((_ event:Event) -> Void)? // Data Binding Closure
    
    var productUseCase: ProductUseCase
    init(productUseCase: ProductUseCase) {
        self.productUseCase = productUseCase
    }
    
    func fetchProductList() {
        self.eventHandler?(.loading)
        self.productUseCase.fetch() { response in
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

