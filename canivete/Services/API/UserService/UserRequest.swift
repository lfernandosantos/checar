//
//  UserRequest.swift
//  canivete
//
//  Created by Luiz Fernando dos Santos on 17/08/20.
//  Copyright © 2020 Luiz Fernando dos Santos. All rights reserved.
//

struct UserRequest: Codable {
    let name: String
    let email: String
}

struct UserResponse {
    let id: String
    let name: String
    let email: String
}
