//
//  SingleProductViewModel.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 13/12/23.
//

import Foundation

/*
 SingleProductModel is a presentational view model for each item. It's optional, but useful for:

 Formatting

 Computed properties

 UI logic separation
 */
class SingleProductViewModel {
    
    var id: Int16 {
        return Int16(product.id)
    }
    
    var favourite: Bool {
        get {
            return product.favourite ?? false
        }
        set(newFavouriteValue) {
            product.favourite = newFavouriteValue
        }
    }
    
    var isDeleted_: Bool {
        get {
            return product.isDeleted_ ?? false
        }
        set(newisDeleted_Value) {
            product.isDeleted_ = newisDeleted_Value
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
