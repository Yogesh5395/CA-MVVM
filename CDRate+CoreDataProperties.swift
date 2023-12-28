//
//  CDRate+CoreDataProperties.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 27/12/23.
//
//

import Foundation
import CoreData


extension CDRate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDRate> {
        return NSFetchRequest<CDRate>(entityName: "CDRate")
    }

    @NSManaged public var count: Int32
    @NSManaged public var id: UUID?
    @NSManaged public var rate: Double
    @NSManaged public var toProduct: CDProduct?

}

extension CDRate : Identifiable {

}
