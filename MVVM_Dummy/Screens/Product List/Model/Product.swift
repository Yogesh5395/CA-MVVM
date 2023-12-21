//
//  Product.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 08/12/23.
//

import Foundation

struct Product: Codable {
    let id: Int16
    let image: String
    let title: String
    let category: String
    let price: Double
    let rating: Rate
    let description: String
    var favourite: Bool? = false
}

struct Rate: Codable {
    let rate: Double
    let count: Int
}
