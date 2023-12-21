//
//  CDProduct+CoreDataProperties.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 21/12/23.
//
//

import Foundation
import CoreData


extension CDProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDProduct> {
        return NSFetchRequest<CDProduct>(entityName: "CDProduct")
    }

    @NSManaged public var category: String?
    @NSManaged public var descriptio_n: String?
    @NSManaged public var id: Int16
    @NSManaged public var image: String?
    @NSManaged public var price: Double
    @NSManaged public var title: String?
    @NSManaged public var favourite: Bool
    @NSManaged public var toRate: CDRate?

}

extension CDProduct : Identifiable {

}
