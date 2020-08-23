//
//  ResponseError.swift
//  cinemap
//
//  Created by Luiz Fernando dos Santos on 30/03/20.
//  Copyright © 2020 Luiz Fernando dos Santos. All rights reserved.
//

public enum ResponseError: Error, Equatable {
    case notFound
    case canceled
    case noInternetConnection
    case errorToParse
    case unknown(reasons: [String])
}
