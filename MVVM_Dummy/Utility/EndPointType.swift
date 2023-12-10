//
//  EndPointType.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 08/12/23.
//

import Foundation

enum HTTPMethods: String {
    case get  = "GET"
    case post = "POST"
}

protocol EndPoints {
    var path: String {get}
    var baseUrl: String {get}
    var url: URL? {get}
    var body: Encodable? {get}
    var headers: [String:String]? {get}
    var method: HTTPMethods {get}
}
