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
        let user = UserRequest(name: "Fernando Santos 123", email: "email.com")
        let dataBody = try? JSONEncoder().encode(user)
        print(String(data: dataBody!, encoding: .ascii)!)
        
        let url = URL(string: "https://checar-service.herokuapp.com/user")!
        let urlRequest = BaseURLRequest(url: url, method: .post, header: [.contentType], body: dataBody)
        BaseHTTPService().createRequest(urlRequest) { (data, error) in
            print("terminou" )
        }
    }
}

// MARK: - LoginManagerComponent Delegate
extension LoginPresenter {
    func didLogin(user: User) {
        print(user)
        DatabaseService.shared.setUser(user: user)
        self.view?.performToHome()
    }
    
    func didLoginFail(error: ResponseError) {
        print(error.localizedDescription)
        self.view?.showError(message: error.localizedDescription)
    }
}
