//
//  AddProductService.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 19/12/23.
//

import Foundation


protocol AddProductService {
    
    func uploadProduct(completion: @escaping (Result<AddProduct, DataError>) -> Void)
}
