//
//  config.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 06/12/23.
//

import Foundation

var productCount: Int = 0

enum Constant {
    
    enum API {
        static let productURL = "https://fakestoreapi.com/products"
    }
}


enum Event {
    case loading
    case stopLoading
    case dataLoad
    case error(Error?)
}
