//
//  ProductEndPointType.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 08/12/23.
//

import Foundation

enum ProductEndPointType {
    case products  // Module - GET
    case addProduct(AddProduct) // - POST
}

extension ProductEndPointType: EndPoints {
    
    var path: String {
        switch self {
        case .products:
            return "products"
        case .addProduct(_):
            return "products/add"
        }
    }
    
    var baseUrl: String {
        switch self {
        case .products:
            return "https://fakestoreapi.com/"
        case .addProduct(_):
            return "https://dummyjson.com/"
        }
    }
    
    var url: URL? {
        return URL(string: "\(baseUrl)\(path)")
    }
    
    var body: Encodable? {
        switch self {
        case .products:
            return nil
        case .addProduct(let product):
            return product
        }
    }
    
    var headers: [String : String]? {
        APIManager.commonHeaders
    }
    
    var method: HTTPMethods {
        switch self {
        case .products:
            return .get
        case .addProduct(_):
            return .post
        }
    }
}
