//
//  PersistentStorage.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 15/12/23.
//

import Foundation
import CoreData

class PersistentStorage {
    
//    private init() {}
//    static let shared = PersistentStorage()
    
    // This initializer is used for testing with in-memory store type
    init(inMemory: Bool = false) {
        if inMemory {
            persistentContainer = NSPersistentContainer(name: "MVVM_Dummy")
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            persistentContainer.persistentStoreDescriptions = [description]
            persistentContainer.loadPersistentStores { (description, error) in
                if let error = error {
                    fatalError("Failed to load in-memory store: \(error)")
                }
            }
        }
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MVVM_Dummy")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    
    lazy var context = persistentContainer.viewContext
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchManagedObject<T: NSManagedObject>(managedObject: T.Type) -> [T]? {
        
        let entityName = String(describing: T.self)
        
        let request = NSFetchRequest<T>(entityName: entityName)
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
            
        do {
            guard let result = try context.fetch(request) as? [T] else {return nil}
            
            return result
            
        } catch let error {
            debugPrint(error)
        }
        
        return nil
    }
    
    func fetchTopManagedObject<T: NSManagedObject>(managedObject: T.Type) -> T? {
        
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: T.self))
        fetchRequest.fetchLimit = 1
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        do {
            let result = try context.fetch(fetchRequest)
            return result.first // Since fetchLimit is 1, the array contains at most one object
        } catch let error {
            print("Error fetching top object: \(error)")
            return nil
        }
    }

    
}
