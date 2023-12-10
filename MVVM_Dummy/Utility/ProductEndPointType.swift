//
//  ProductEndPointType.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 08/12/23.
//

import Foundation

enum ProductEndPointType {
    case products  // Module - GET
}

extension ProductEndPointType: EndPoints {
    
    var path: String {
        switch self {
        case .products:
            return "products"
        }
    }
    
    var baseUrl: String {
        switch self {
        case .products:
            return "https://fakestoreapi.com/"
        }
    }
    
    var url: URL? {
        return URL(string: "\(baseUrl)\(path)")
    }
    
    var body: Encodable? {
        switch self {
        case .products:
            return nil
        }
    }
    
    var headers: [String : String]? {
        APIManager.commonHeaders
    }
    
    var method: HTTPMethods {
        switch self {
        case .products:
            return .get
        }
    }
}
