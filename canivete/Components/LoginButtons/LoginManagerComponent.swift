//
//  LoginManager.swift
//  cinemap
//
//  Created by Luiz Fernando dos Santos on 14/06/20.
//  Copyright © 2020 Luiz Fernando dos Santos. All rights reserved.
//

import Foundation
import FBSDKLoginKit
//import GoogleSignIn
//import FirebaseAuth


protocol LoginManagerComponentDelegate {
    func didLogin(user: User)
    func didLoginFail(error: ResponseError)
}

final class LoginManagerComponent: NSObject {
    
    private let fbLoginManager: LoginManager
    private var userAccessCompletion: ((Bool) -> Void)?
    
    public static let shared: LoginManagerComponent = LoginManagerComponent()
    public var delegate: LoginManagerComponentDelegate?
    public var user: User?
    
    private init(fbLoginManager: LoginManager = LoginManager()) {
        self.fbLoginManager = fbLoginManager
    }
    
    func logout() {
        self.fbLoginManager.logOut()
    }
    
    func userAccess(completion: @escaping (Bool) -> Void) {
        GoogleSignInRequest().userAccess(completion: completion)
    }
}

extension LoginManagerComponent {
    enum FBLoginParams: String {
        case PROFILE        = "public_profile"
        case EMAIL          = "email"
        case USER_FRIENDS   = "user_friends"
        case USER_PHOTO     = "user_photos"
        case all            = "id, name, email, first_name, last_name, picture.type(large)"
    }
    
    enum LoginResultStatus {
        case canceled
        case success(user: User)
        case fail(error: String)
    }
}

//  MARK: - FBLoginDelegate GoogleSignInDelegate

extension LoginManagerComponent: FBLoginDelegate, GoogleSignInDelegate {
    func didLogin(result: Result<User, ResponseError>) {
        switch result {
        case .success(let user):
            self.delegate?.didLogin(user: user)
            self.userAccessCompletion?(true)
        case .failure(let error):
            self.delegate?.didLoginFail(error: error)
            self.userAccessCompletion?(false)
        }
    }
}

//  MARK: - AppleLoginDelegate

extension LoginManagerComponent: AppleLoginDelegate {
    func didLogin(result: Result<Bool, ResponseError>) {
        
    }
}


