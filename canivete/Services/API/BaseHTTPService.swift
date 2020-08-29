//
//  BaseHTTPService.swift
//  canivete
//
//  Created by Luiz Fernando dos Santos on 17/08/20.
//  Copyright © 2020 Luiz Fernando dos Santos. All rights reserved.
//

import Foundation

struct BaseURLRequest {
    var url: URL
    var method: BaseHTTPService.HTTPMethod = .get
    var header: [BaseHTTPService.HTTPHeader] = [.contentType]
    var body: Data? = nil
}

final class BaseHTTPService {
    
    private let session: URLSession = URLSession.shared
    
    func createRequest(_ baseURLRequest: BaseURLRequest,
                       completion: @escaping (Data?, ResponseError?) -> Void) {
        
        let urlRequest = self.getURLRequest(with: baseURLRequest)
        let task = session.dataTask(with: urlRequest) { (data, response, error)  in
            DispatchQueue.main.async {
                if let error = error {
                    print(error.localizedDescription)
                }
                
                guard let data = data, error == nil else {
                    completion(nil, ResponseError.unknown(reasons: [error?.localizedDescription ?? ""]))
                    return
                }
                completion(data, nil)
            }
            
        }
        DispatchQueue.global(qos: .background).async {
            task.resume()
        }
    }
    
    private func getURLRequest(with base: BaseURLRequest) -> URLRequest {
        var urlRequest = URLRequest(url: base.url)
        urlRequest.httpMethod = base.method.rawValue
        urlRequest.httpBody = base.body
        base.header.forEach{ urlRequest.setValue($0.value, forHTTPHeaderField: $0.field) }
        return urlRequest
    }
}

extension BaseHTTPService {
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    enum HTTPHeader {
        case contentType
        
        var value: String {
            switch self {
            case .contentType:
                return "application/json; charset=utf-8"
            }
        }
        
        var field: String {
            switch self {
            case .contentType:
                return "Content-Type"
            }
        }
    }
}


