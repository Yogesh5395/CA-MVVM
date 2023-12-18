//
//  ProductDatamanager.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 18/12/23.
//

import Foundation
import CoreData

struct ProductDataManager {
    
    func inserData(record: SingleProductViewModel) {
        
        let cdProduct = CDProduct(context: PersistentStorage.shared.context)
        
//        cdProduct.id = record.id
        cdProduct.image = record.image
        cdProduct.title = record.title
        cdProduct.price = record.price
        cdProduct.category = record.category
        cdProduct.descriptio_n = record.description
        
        
        let cdRate = CDRate(context: PersistentStorage.shared.context)
        cdRate.rate = record.rating.rate
        cdRate.count = Int32(record.rating.count)
        
        PersistentStorage.shared.saveContext()
    }
    
    func fetchProducts() -> [Product]? {
        
        let records = PersistentStorage.shared.fetchManagedObject(managedObject: CDProduct.self)
        
        guard records != nil && records?.count != 0 else {return nil}
        
        var results: [Product] = []
        
        records!.forEach({ (cdProduct) in
            results.append(cdProduct.convertToProduct())
        })
        
        return results
    }
}

