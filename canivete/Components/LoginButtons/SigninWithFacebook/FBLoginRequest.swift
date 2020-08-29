//
//  FBLoginRequest.swift
//  friendtrip
//
//  Created by Luiz Fernando dos Santos on 17/11/19.
//  Copyright © 2019 Luiz Fernando dos Santos. All rights reserved.
//

import Foundation
import FBSDKLoginKit

protocol FBLoginRequestProtocol {
    var loginDelegate: FBLoginDelegate? { get set }
    
    func pressedLoginButton(view: UIViewController,
                          params: [FBLoginRequest.FBLoginParams])
}

protocol FBLoginDelegate {
    func didLogin(result: Result<UserComponentEntity, ResponseError>)
}

//MARK: - Implementation

final class FBLoginRequest: FBLoginRequestProtocol {
    
    private let loginManager: LoginManager
    
    var loginDelegate: FBLoginDelegate?

    
    init(loginManager: LoginManager = LoginManager()) {
        self.loginManager = loginManager
    }
    
    func pressedLoginButton(view: UIViewController, params: [FBLoginParams]) {
        let param: [String] = params.compactMap({ $0.rawValue })
        
        self.loginManager.logIn(permissions: param, from: view) { (result, error) in
            
            if let error = error {
                self.loginDelegate?.didLogin(result: Result.failure(.unknown(reasons: [error.localizedDescription])))
                       return
            }
            
            guard let result = result else {
                self.loginDelegate?.didLogin(result: .failure(.unknown(reasons: ["result nil"])))
                return
            }
            
            if result.isCancelled {
                self.loginDelegate?.didLogin(result: .failure(.canceled))
                return
            }
            
            guard let _ = result.token else {
                self.loginDelegate?.didLogin(result: .failure(.unknown(reasons: ["token nil"])))
                return
            }
            
            self.getUserInfo { [weak self] (result) in
                self?.loginDelegate?.didLogin(result: result)
            }
            
        }
    }
    
    func getUserInfo(completion: @escaping (Result<UserComponentEntity, ResponseError>) -> Void) {
        GraphRequest(graphPath: "me", parameters: ["fields": "email, name, picture.type(large)"]).start { (connection, result, error) in

            guard let json = result as? [String: Any] else {
                completion(.failure(.errorToParse))
                return
            }
            guard let data = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed) else {
                completion(.failure(.errorToParse))
                return
            }
            guard let user = try? JSONDecoder().decode(UserComponentEntity.self, from: data) else {
                completion(.failure(.errorToParse))
                return
            }
            
            completion(.success(user))
        }
    }
}

extension FBLoginRequest {
    enum FBLoginParams: String {
        case PROFILE        = "public_profile"
        case EMAIL          = "email"
        case USER_FRIENDS   = "user_friends"
        case USER_PHOTO     = "user_photos"
        case all            = "id, name, email, first_name, last_name, picture.type(large)"
    }
}
