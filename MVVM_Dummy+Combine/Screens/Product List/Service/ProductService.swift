//
//  ProductService.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 13/12/23.
//

import Foundation
import Combine

protocol ProductService {
    func fetch() -> Future<[Product], DataError>
}
