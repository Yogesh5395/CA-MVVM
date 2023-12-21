//
//  CoreData_ProductExtension.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 18/12/23.
//

import Foundation
import CoreData

extension CDProduct
{
    func convertToProduct() -> Product {
        return Product(id: self.id, image: image ?? "", title: title ?? "", category: category ?? "", price: price , rating: self.toRate?.convertToRate() ?? Rate(rate: 0.0, count: 0), description: description, favourite: favourite)
    }
}

extension CDRate
{
    func convertToRate() -> Rate {
        return Rate(rate: self.rate, count: Int(self.count))
    }
}
