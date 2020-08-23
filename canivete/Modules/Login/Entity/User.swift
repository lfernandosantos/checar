//
//  User.swift
//  cinemap
//
//  Created by Luiz Fernando dos Santos on 14/04/20.
//  Copyright © 2020 Luiz Fernando dos Santos. All rights reserved.
//

import Foundation

struct User: Decodable, Encodable {
    let name: String
    let email: String?
    let picture: Picture?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case email = "email"
        case picture = "picture"
    }
}

struct PictureData: Decodable, Encodable {
    let isSilhouette: Bool
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case isSilhouette = "is_silhouette"
        case url = "url"
    }
}

struct Picture: Decodable, Encodable {
    let data: PictureData?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}
