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
    
    var products: [Product] = []
    var filteredProducts: [Product] = []
    var eventHandler: ((_ event:Event) -> Void)? // Data Binding Closure
    
    func fetchProducts() {
        self.eventHandler?(.loading)
        APIManager.shared.request(
            modelType: [Product].self,
            type: ProductEndPointType.products) { response in
                self.eventHandler?(.stopLoading)
                switch response {
                case .success(let products):
                    self.products = products
                    self.eventHandler?(.dataLoad)
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
    }
}

