//
//  APIManager.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 08/12/23.
//

import Foundation

enum DataError: Error {
    case invalidRespose
    case invalidUrl
    case invalidDate
    case network(Error?)
    case decoding(Error?)
}

typealias ResultHandler<T> = (Result<T, DataError>) -> Void

class APIManager {
    
    static let shared          = APIManager()
    private var networkhandler = NetworkHandler()
    private var reponseHandler = ResponseHandler()
    
    init(networkhandler: NetworkHandler = NetworkHandler(), responseHandler: ResponseHandler = ResponseHandler()) {
        
        self.networkhandler = NetworkHandler()
        self.reponseHandler = ResponseHandler()
    }
    
    func request<T: Codable>(modelType: T.Type, type: EndPoints, completion: @escaping ResultHandler<T>) {
        
        guard let url = type.url else {
            return completion(.failure(.invalidUrl))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = type.method.rawValue
        
        if let parameter = type.body {
            request.httpBody = try? JSONEncoder().encode(parameter)
        }
        
        request.allHTTPHeaderFields = type.headers
        
        networkhandler.requestDataAPI(url: request) { result in
            
            switch result {
            case .success(let data):
                // Json parsing - Decoder - DATA TO MODEL
                self.reponseHandler.parseResonseDecode(data: data, modelType: modelType) { response in
                    
                    switch response {
                    case .success(let mainResponse):
                        completion(.success(mainResponse))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                    
                }
            case .failure(let error):
                completion(.failure(error))
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
            
            guard let data, error == nil else {
                completionHandler(.failure(.invalidDate))
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
        }catch {
            completionHandler(.failure(.decoding(error)))
        }
    }
}
