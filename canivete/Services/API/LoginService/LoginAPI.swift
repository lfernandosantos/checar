//
//  LoginAPI.swift
//  canivete
//
//  Created by Luiz Fernando dos Santos on 23/08/20.
//  Copyright © 2020 Luiz Fernando dos Santos. All rights reserved.
//

import Foundation

final class LoginAPI {
    
    let httpService: BaseHTTPService
    
    init(httpService: BaseHTTPService = BaseHTTPService()) {
        self.httpService = httpService
    }
    
    func login(with user: UserRequest, completion: @escaping ((UserRequest?, ResponseError?) -> Void)) {
        guard let url = URL(string: HerokuAPI.Endpoint.user.url) else { return }
        
        let dataBody = try? JSONEncoder().encode(user)
        let urlRequest = BaseURLRequest(url: url, method: .post, body: dataBody)
        
        self.httpService.createRequest(urlRequest) { (resultData, error) in
            guard error == nil, let data = resultData else {
                completion(nil, error)
                return
            }
            
            let userRequest = try? JSONDecoder().decode(UserRequest.self, from: data)
            completion(userRequest, nil)
        }
        
    }
}
