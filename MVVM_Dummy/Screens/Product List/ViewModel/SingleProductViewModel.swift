//
//  SingleProductViewModel.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 13/12/23.
//

import Foundation

class SingleProductViewModel {
    
    var id: Int16 {
        return product.id
    }
    
    var favourite: Bool {
        get {
            return product.favourite
        }
        set(newFavouriteValue) {
            product.favourite = newFavouriteValue
        }
    }
    
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
