//
//  AddProductService.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 19/12/23.
//

import Foundation
import Combine

protocol AddProductService {
    func uploadProduct() -> Future<AddProduct, DataError>
}
