//
//  BaseAPI.swift
//  canivete
//
//  Created by Luiz Fernando dos Santos on 17/08/20.
//  Copyright © 2020 Luiz Fernando dos Santos. All rights reserved.
//

import Foundation

final class BaseAPIHeroku {
    let baseURL: String = "https://checar-service.herokuapp.com/"
    
    
}

extension BaseAPIHeroku {
    enum endpoint: String {
        case user = "user/"
    }
}
