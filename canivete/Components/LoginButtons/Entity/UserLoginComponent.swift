//
//  UserLoginComponent.swift
//  canivete
//
//  Created by Luiz Fernando dos Santos on 15/08/20.
//  Copyright © 2020 Luiz Fernando dos Santos. All rights reserved.
//

import Foundation

public protocol UserLoginComponentProtocol {
    var name: String { get set }
    var email: String? { get set }
    var profileURL: URL? { get set }
}

private struct UserLoginComponent: UserLoginComponentProtocol {
    var name: String
    var email: String?
    var profileURL: URL?
}
