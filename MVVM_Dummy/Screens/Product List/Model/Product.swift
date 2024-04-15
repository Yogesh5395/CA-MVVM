//
//  Product.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 08/12/23.
//

import Foundation

struct Product: Codable {
    let id: Int
    let image: String
    let title: String
    let category: String
    let price: Double
    let rating: Rate
    let description: String
    var favourite: Bool? = false
    var isDeleted_: Bool? = false

    init(id: Int, image: String, title: String, category: String, price: Double, rating: Rate, description: String, favourite: Bool, isDeleted_: Bool) {
        self.id = id
        self.image = image
        self.title = title
        self.category = category
        self.price = price
        self.rating = rating
        self.description = description
        self.favourite = favourite
        self.isDeleted_ = isDeleted_
    }
}

struct Rate: Codable {
    let rate: Double
    let count: Int
    
    init(rate: Double, count: Int) {
        self.rate = rate
        self.count = count
    }
}
