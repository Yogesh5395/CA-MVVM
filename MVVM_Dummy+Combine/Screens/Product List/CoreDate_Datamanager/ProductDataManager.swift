//
//  ProductDatamanager.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 18/12/23.
//

import Foundation
import CoreData

struct ProductDataManager {
    
    let persistentStorageObj: PersistentStorage
    
    init(persistentStorageObj: PersistentStorage) {
        self.persistentStorageObj = persistentStorageObj
    }
    
    func insertData(record: SingleProductViewModel) {
        
        let cdProduct = CDProduct(context: persistentStorageObj.context)
        
        cdProduct.id           = record.id//Int16(record.id)
        cdProduct.image        = record.image
        cdProduct.title        = record.title
        cdProduct.price        = record.price
        cdProduct.category     = record.category
        cdProduct.descriptio_n = record.description
        cdProduct.isDeleted_   = record.isDeleted_
        
        
        let cdRate   = CDRate(context: persistentStorageObj.context)
        cdRate.rate  = record.rating.rate
        cdRate.count = Int32(record.rating.count)
        
        persistentStorageObj.saveContext()
    }
    
    func fetchProducts() -> [Product]? {
        
        let records = persistentStorageObj.fetchManagedObject(managedObject: CDProduct.self)
        
        guard records != nil && records?.count != 0 else {return nil}
        
        var results: [Product] = []
        
        records!.forEach({ (cdProduct) in
            results.append(cdProduct.convertToProduct())
        })
        
        return results
    }
    
    func fetchTopProduct() -> Product? {
        
        let record = persistentStorageObj.fetchTopManagedObject(managedObject: CDProduct.self)
        
        guard record != nil else {return nil}
        
        return record?.convertToProduct()
    }
    
    func updateProductFavouriteStatus(forID id: Int16, toNewStatus newStatus: Bool) {
        let fetchRequest: NSFetchRequest<CDProduct> = CDProduct.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)

        do {
            let result = try persistentStorageObj.context.fetch(fetchRequest)
            if let objectToUpdate = result.first {
                objectToUpdate.favourite = newStatus
                try persistentStorageObj.context.save()
            }
        } catch {
            print("Error updating favourite status: \(error)")
        }
    }
    
    func updateProductFavouriteDeleteStatus(forID id: Int16, toNewStatus newStatus: Bool) {
        let fetchRequest: NSFetchRequest<CDProduct> = CDProduct.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)

        do {
            let result = try persistentStorageObj.context.fetch(fetchRequest)
            if let objectToUpdate = result.first {
                objectToUpdate.isDeleted_ = newStatus
                try persistentStorageObj.context.save()
            }
        } catch {
            print("Error updating favourite status: \(error)")
        }
    }
    
    func getProduct(forID id: Int16) -> CDProduct{
        let fetchRequest: NSFetchRequest<CDProduct> = CDProduct.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)

        let result = try! persistentStorageObj.context.fetch(fetchRequest)
        
        guard result.count != 0 else {return CDProduct()}

        return result.first ?? CDProduct()
    }
    
    func deleteProduct(forID id: Int16) -> Bool{
        
        let product = getProduct(forID: id)
        
        persistentStorageObj.context.delete(product)
        try! persistentStorageObj.context.save()
        
        return true
    }

}

