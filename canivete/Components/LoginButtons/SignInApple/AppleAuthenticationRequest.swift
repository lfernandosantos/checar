//
//  AppleAuthenticationRequest.swift
//  friendtrip
//
//  Created by Luiz Fernando dos Santos on 08/12/19.
//  Copyright © 2019 Luiz Fernando dos Santos. All rights reserved.
//

import Foundation
import AuthenticationServices

protocol AppleLoginDelegate: AnyObject {
    func didLogin(result: Result<Bool, ResponseError>)
}

protocol AppleAuthenticationRequestProtocol {
    var delegate: AppleLoginDelegate? { get set }
    
    func appleLogin()
}

final class AppleAuthenticationRequest: NSObject {
    var controller: ASAuthorizationController
    weak var delegate: AppleLoginDelegate?
    
    override init() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        self.controller = ASAuthorizationController(authorizationRequests: [request])
        super.init()
        self.controller.delegate = self
    }
    
    func appleLogin() {
        controller.performRequests()
    }
}

extension AppleAuthenticationRequest: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        delegate?.didLogin(result: .success(true))
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        delegate?.didLogin(result: .failure(.unknown(reasons: [error.localizedDescription])))
    }
}
