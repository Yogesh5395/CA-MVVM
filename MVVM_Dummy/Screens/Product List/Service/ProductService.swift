//
//  ProductService.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 13/12/23.
//

import Foundation

protocol ProductService {
    func fetch(completion: @escaping(Result<[Product], DataError>) -> Void)    
}
