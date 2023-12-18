//
//  RateDatamanager.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 18/12/23.
//

import Foundation
import CoreData

struct RateDataManager {
    
    func inserData(record: Rate) {
        let CDRate = CDRate(context: PersistentStorage.shared.context)
        CDRate.count = Int32(record.count)
        CDRate.rate = record.rate
    }
}
