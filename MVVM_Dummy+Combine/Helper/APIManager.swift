//
//  APIManager.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 08/12/23.
//

import Foundation
import Combine

protocol NetworkManager {
    func requestItems<T: Codable>(modelType: T.Type, type: EndPoints) -> Future<T, DataError>
}

enum DataError: Error {
    case invalidRespose
    case invalidUrl
    case invalidData
    case network(Error?)
    case decoding(Error?)
}

typealias ResultHandler<T> = (Result<T, DataError>) -> Void

class APIManager: NetworkManager {
    
    private var networkHandler: NetworkHandler
    private var responseHandler: ResponseHandler
    
    init(networkHandler: NetworkHandler = NetworkHandler(), responseHandler: ResponseHandler = ResponseHandler()) {
        self.networkHandler = networkHandler
        self.responseHandler = responseHandler
    }
    
    func requestItems<T: Codable>(modelType: T.Type, type: EndPoints) -> Future<T, DataError> {
        return Future { promise in
            guard let url = type.url else {
                return promise(.failure(.invalidUrl))
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = type.method.rawValue
            
            if let parameter = type.body {
                request.httpBody = try? JSONEncoder().encode(parameter)
            }
            
            request.allHTTPHeaderFields = type.headers
            //request: https://fakestoreapi.com/products
            self.networkHandler.requestDataAPI(url: request) { result in
                switch result {
                case .success(let data):
                    self.responseHandler.parseResonseDecode(data: data, modelType: modelType) { response in
                        switch response {
                        case .success(let mainResponse):
                            promise(.success(mainResponse))
                        case .failure(let error):
                            promise(.failure(error))
                        }
                    }
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
    }
    
    static var commonHeaders: [String: String] {
        return [
            "Content-Type": "application/json"
        ]
    }
}

class NetworkHandler {
    
    func requestDataAPI(url: URLRequest, completionHandler: @escaping (Result<Data, DataError>) -> Void) {
        
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let response = response as? HTTPURLResponse, 200 ... 209 ~= response.statusCode else {
                completionHandler(.failure(.invalidRespose))
                return
            }
            
            guard let data = data, error == nil else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            completionHandler(.success(data))
        }
        
        session.resume()
    }
}

class ResponseHandler {
    
    func parseResonseDecode<T: Decodable>(data: Data, modelType: T.Type, completionHandler: ResultHandler<T>) {
        do {
            let userResponse = try JSONDecoder().decode(modelType, from: data)
            completionHandler(.success(userResponse))
        } catch {
            completionHandler(.failure(.decoding(error)))
        }
    }
}
