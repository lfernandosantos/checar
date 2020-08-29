//
//  UserRequest.swift
//  canivete
//
//  Created by Luiz Fernando dos Santos on 17/08/20.
//  Copyright © 2020 Luiz Fernando dos Santos. All rights reserved.
//

import Foundation

struct UserRequest: Codable {
    var id: String? = nil
    let name: String
    let email: String
}

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let profileImageURL: URL?
}
