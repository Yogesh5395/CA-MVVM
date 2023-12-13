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

class SingleProductViewModel {
    
    var title: String {
        return product.title
    }
    
    var image: String {
        return product.image
    }
    
    var category: String {
        return product.category
    }
    var price: Double {
        return product.price
    }
    var description: String {
        return product.description
    }
    
    var rating: Rate {
        return product.rating
    }
    
    private var product: Product

    init(product: Product) {
        self.product = product
    }
}

final class ProductViewModel {
    
    var products: [Product] = []
    var filteredProducts: [Product] = []
    
    var productsVM:[SingleProductViewModel] = []
    var filteredProductsVM: [SingleProductViewModel] = []
    
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
                    self.productsVM = products.map{SingleProductViewModel(product: $0)}
                    self.eventHandler?(.dataLoad)
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
    }
}

