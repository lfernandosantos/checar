//
//  BaseAPI.swift
//  canivete
//
//  Created by Luiz Fernando dos Santos on 17/08/20.
//  Copyright © 2020 Luiz Fernando dos Santos. All rights reserved.
//

import Foundation

final class HerokuAPI {
    enum Endpoint: String {
        case user = "user/"
        
        private var baseURL: String {
            return "https://checar-service.herokuapp.com/"
        }
        
        var url: String {
            switch self {
            case .user:
                return baseURL + self.rawValue
            }
        }
    }
}
