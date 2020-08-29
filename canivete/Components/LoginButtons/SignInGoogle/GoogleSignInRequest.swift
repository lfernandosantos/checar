//
//  GoogleSignInRequest.swift
//  cinemap
//
//  Created by Luiz Fernando dos Santos on 23/05/20.
//  Copyright © 2020 Luiz Fernando dos Santos. All rights reserved.
//

import Foundation
//import GoogleSignIn

protocol GoogleSignInRequestProtocol {
    func login()
}

protocol GoogleSignInDelegate {
    func didLogin(result: Result<UserComponentEntity, ResponseError>)
}

final class GoogleSignInRequest: NSObject, GoogleSignInRequestProtocol {
    
//    let googleSignInIntance: GIDSignIn? = GIDSignIn.sharedInstance()
    var delegate: GoogleSignInDelegate?
    private var userAccessCompletion: ((Bool) -> Void)?
    
    override init() {
        super.init()
//        self.googleSignInIntance?.delegate = self
    }
    
    func login() {
//        self.googleSignInIntance?.signIn()
    }
    
    func userAccess(completion: @escaping (Bool) -> Void) {
        self.userAccessCompletion = completion
//        GIDSignIn.sharedInstance()?.delegate = self
//        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
}

//extension GoogleSignInRequest: GIDSignInDelegate {
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//        guard error == nil else {
//            self.delegate?.didLogin(result: .failure(.unknown(reasons: [error.debugDescription])))
//            self.userAccessCompletion?(false)
//            return
//        }
//        
//        let imageURL = user.profile.imageURL(withDimension: 100)
//        let picture = Picture(data: PictureData(isSilhouette: false, url: imageURL?.absoluteString))
//        let cinemapUser = User(name: user.profile.name, email: user.profile.email, picture: picture)
//        self.delegate?.didLogin(result: .success(cinemapUser))
//        self.userAccessCompletion?(true)
//    }
//}
