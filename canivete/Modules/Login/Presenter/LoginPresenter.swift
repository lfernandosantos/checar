//
//  LoginPresenter.swift
//  canivete
//
//  Created by Luiz Fernando dos Santos on 15/08/20.
//  Copyright © 2020 Luiz Fernando dos Santos. All rights reserved.
//

import Foundation

protocol LoginPresenterProtocol: AnyObject, LoginManagerComponentDelegate {
    func viewDidLoad()
}

final class LoginPresenter: LoginPresenterProtocol {
    
    private let loguinManagerComponent: LoginManagerComponent
    private weak var view: LoginViewController?
    
    init(view: LoginViewController,
         loginManager: LoginManagerComponent = LoginManagerComponent.shared) {
        self.view = view
        self.loguinManagerComponent = loginManager
    }
    
    func viewDidLoad() {
    }
    
    private func loginUserAPI(user: UserComponentEntity) {
        guard let email = user.email else { return }
        let userRequest = UserRequest(id: nil,name: user.name, email: email)
        
        LoginAPI().login(with: userRequest) { [weak self] (data, error) in
            guard let id = data?.id ,
                let email = user.email,
                let profile = user.picture?.data?.url else { return }
            let userToSave = User(id: id, name: user.name, email: email, profileImageURL: URL(string: profile))
            DatabaseService.shared.setUser(user: userToSave)
            self?.view?.performToHome()
        }
    }
}

// MARK: - LoginManagerComponent Delegate
extension LoginPresenter {
    func didLogin(user: UserComponentEntity) {
        self.loginUserAPI(user: user)
        
    }
    
    func didLoginFail(error: ResponseError) {
        print(error.localizedDescription)
        self.view?.showError(message: error.localizedDescription)
    }
}
