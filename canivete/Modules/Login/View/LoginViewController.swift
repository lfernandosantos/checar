//
//  LoginViewController.swift
//  canivete
//
//  Created by Luiz Fernando dos Santos on 15/08/20.
//  Copyright © 2020 Luiz Fernando dos Santos. All rights reserved.
//

import UIKit

protocol LoginViewProtocol {
    func performToHome()
    func showError(message: String)
}

final class LoginViewController: UIViewController {

    @IBOutlet private weak var loginButtonsView: LoginButtonsView!
    private var presenter: LoginPresenterProtocol?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.presenter = LoginPresenter(view: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupButons()
        
        self.loginButtonsView.setDelegate(self.presenter)
        self.presenter?.viewDidLoad()
    }
    
    private func setupButons() {
        self.loginButtonsView.configureButtons(facebook: true)
    }
}

// MARK: - LoginViewProtocol

extension LoginViewController: LoginViewProtocol {
    func performToHome() {
        FlowController.shared.openHome(view: self)
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
