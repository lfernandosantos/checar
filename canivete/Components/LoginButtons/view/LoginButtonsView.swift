//
//  LoginButtonsView.swift
//  friendtrip
//
//  Created by Luiz Fernando dos Santos on 16/11/19.
//  Copyright © 2019 Luiz Fernando dos Santos. All rights reserved.
//

import UIKit
import FBSDKLoginKit

final class LoginButtonsView: UIView {
    
    // MARK: - Request
    
    var facebookLoginRequest = FBLoginRequest()
    var appleLoginRequest = AppleAuthenticationRequest()
    var googleRequest = GoogleSignInRequest()
    
    var viewBackground: UIView?
    
    // MARK: - Private Outlet
    
    @IBOutlet private weak var stackview: UIStackView!
    @IBOutlet private weak var appleButton: UIButton!
    @IBOutlet private weak var facebookButton: UIButton!
    @IBOutlet private weak var googleButton: UIButton!
    
    private let loginManager: LoginManagerComponent = LoginManagerComponent.shared
    private weak var viewContainer: UIView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupXib()
        self.configure()
    }
    
    // MARK: - Override
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupXib()
        self.configure()
    }
    
    override func layoutSubviews() {
        self.resizeViews()
    }
    
    // MARK: - Public
    
    func configureButtons(apple: Bool = false, facebook: Bool = false, google: Bool = false) {
        appleButton.isHidden = !apple
        facebookButton.isHidden = !facebook
        googleButton.isHidden = !google
    }
    
    func setDelegate(_ delegate: LoginManagerComponentDelegate?) {
        self.loginManager.delegate = delegate
    }
    
    //MARK: - Buttons Actions
    
    @IBAction func press(_ sender: Any) {
        if let currentViewController = UIApplication.shared.windows.first?.rootViewController {
            self.facebookLoginRequest.pressedLoginButton(view: currentViewController, params: [.PROFILE,.EMAIL, .USER_FRIENDS, .USER_PHOTO])
        }
    }
    
    @IBAction func pressAppleButton(_ sender: Any) {
        self.appleLoginRequest.appleLogin()
    }
    
    @IBAction func pressGoogleButton(_ sender: Any) {
        self.googleRequest.login()
    }
    
    // MARK: - Private
    
    private func setupXib() {
        let nib = UINib(nibName: "LoginButtonsView", bundle: nil)
        viewContainer = nib.instantiate(withOwner: self, options: nil).first! as? UIView
        viewContainer.backgroundColor = .clear
        
        self.setupFacebookButton()
        self.setupGoogleButton()
        
        self.addSubview(viewContainer)
    }
    
    private func configure() {
        self.facebookLoginRequest.loginDelegate = self.loginManager
        self.appleLoginRequest.delegate = self.loginManager
        self.googleRequest.delegate = self.loginManager
    }
    
    private func setupFacebookButton() {
        let icon = UIImage(named: "facebook-icon")
        self.facebookButton.setImage(icon, for: .normal)
        self.facebookButton.imageView?.contentMode = .scaleAspectFit
        self.facebookButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
    }
    
    private func setupGoogleButton() {
        let icon = UIImage(named: "google-icon")
        self.googleButton.setImage(icon, for: .normal)
        self.googleButton.imageView?.contentMode = .scaleAspectFit
        self.googleButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
    }
    
    private func resizeViews() {
        viewContainer.frame = self.bounds
        viewContainer.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        
        self.appleButton.layer.cornerRadius = 8
        
        self.facebookButton.layer.cornerRadius = self.facebookButton.bounds.height / 2
        self.facebookButton.layer.borderColor = #colorLiteral(red: 0.9240934253, green: 0.9093549252, blue: 0, alpha: 1)
        self.facebookButton.layer.borderWidth = 1
        
        self.googleButton.layer.cornerRadius = self.googleButton.bounds.height / 2
        self.googleButton.layer.borderColor = #colorLiteral(red: 0.9240934253, green: 0.9093549252, blue: 0, alpha: 1)
        self.googleButton.layer.borderWidth = 1
    }
}
