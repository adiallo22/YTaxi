//
//  Login.swift
//  YTaxi
//
//  Created by Abdul Diallo on 10/5/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import SnapKit

class Login : UIViewController {
    
    private let loginService = LoginService()
    
    private var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "Avenir-Light", size: 30)
        label.text = "HEY TAXI"
        label.textColor = .customWhiteForDarkMode()
        return label
    }()
    
    private var emailTextField : UITextField = {
        let tf = UITextField().textField(withPlaceholder: "Email", isSecuredEntry: false)
        return tf
    }()
    
    private var passwordTextField : UITextField = {
        let tf = UITextField().textField(withPlaceholder: "Password", isSecuredEntry: true)
        return tf
    }()
    
    private lazy var emailContainerView : UIView = {
        let view = UIView().inputContainerView(withIcon: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), and: emailTextField)
        view.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        return view
    }()
    
    private lazy var passwordContainerView : UIView = {
        let view = UIView().inputContainerView(withIcon: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), and: passwordTextField)
        view.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        return view
    }()
    
    private var loginButton : UIButton = {
        let button = UIButton().authenticationButton(withTitle: "Sign In")
        button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        return button
    }()
    
    private var signUpButton : UIButton = {
        let button = UIButton().segueButton(withTitle: "Don't have an account? ", of: "Sign Up")
        button.addTarget(self, action: #selector(openSignUp), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

//MARK: - helpers and configurations
extension Login {
    
    fileprivate func configureUI() {
        configureNavigationController()
        view.backgroundColor = .backgroundColor()
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        //
        let stack : UIStackView = {
            let stack = UIStackView.init(arrangedSubviews: [emailContainerView,
                                                            passwordContainerView,
                                                            loginButton])
            stack.spacing = 20
            stack.axis = .vertical
            stack.distribution = .fillEqually
            return stack
        }()
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-40)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        //
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(25)
        }
    }
    
    fileprivate func configureNavigationController() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
}

//MARK: - selectors

extension Login {
    
    @objc func openSignUp() {
        let signupController = Signup()
        navigationController?.pushViewController(signupController, animated: true)
    }
    
    @objc func handleSignIn() {
        guard let email = emailTextField.text,
            let password = passwordTextField.text else { return }
        signUserIn(with: email, and: password)
    }

}

//MARK: - API

extension Login {
    fileprivate func signUserIn(with email : String, and password : String) {
        loginService.login(withEmail: email, and: password) { [weak self] error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
//            self?.dismiss(animated: true, completion: nil)
            self?.navigationController?.popViewController(animated: true)
        }
    }
}


