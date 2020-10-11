//
//  Signup.swift
//  YTaxi
//
//  Created by Abdul Diallo on 10/5/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class Signup : UIViewController {
    
    //MARK: - properties
    
    private let signupService = SignupService()
    
    private var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "Avenir-Light", size: 30)
        label.text = "HEY TAXI"
        label.textColor = .customWhiteForDarkMode()
        return label
    }()
    
    private lazy var fullnameContainer : UIView = {
        let view = UIView().inputContainerView(withIcon: #imageLiteral(resourceName: "ic_person_outline_white_2x"), and: fullnameTextField)
        view.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        return view
    }()
    
    private lazy var emailContainer : UIView = {
        let view = UIView().inputContainerView(withIcon: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), and: emailTextField)
        view.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        return view
    }()
    
    private lazy var passwordContainer : UIView = {
        let view = UIView().inputContainerView(withIcon: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), and: passwordTextField)
        view.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        return view
    }()
    
    private lazy var profileoptionContainer : UIView = {
        let view = UIView().inputContainerView(withIcon: #imageLiteral(resourceName: "ic_account_box_white_2x"), andSegment: profileOption)
        view.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        return view
    }()
    
    private var fullnameTextField : UITextField = {
        let textField = UITextField().textField(withPlaceholder: "Full Name", isSecuredEntry: false)
        return textField
    }()
    
    private var emailTextField : UITextField = {
        let textField = UITextField().textField(withPlaceholder: "Email", isSecuredEntry: false)
        return textField
    }()
    
    private var passwordTextField : UITextField = {
        let textField = UITextField().textField(withPlaceholder: "Password", isSecuredEntry: true)
        return textField
    }()
    
    private var profileOption : UISegmentedControl = {
        let picker = UISegmentedControl.init(items: ["Rider", "Driver"])
        picker.selectedSegmentIndex = 0
        picker.backgroundColor = .lightGray
        picker.selectedSegmentTintColor = .customWhiteForDarkMode()
        return picker
    }()
    
    private var signupButton : UIButton = {
        let button = UIButton().authenticationButton(withTitle: "Sign Up")
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        return button
    }()
    
    private var backToLoginButton : UIButton = {
        let button = UIButton().segueButton(withTitle: "Already have an account? ", of: "Sign In")
        button.addTarget(self, action: #selector(openSignIn), for: .touchUpInside)
        return button
    }()
    
    //MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        let locationManger = LocationHandler.shared.locationManager
        print(locationManger?.location)
    }
    
}

//MARK: - Helpers and Configurations

extension Signup {
    
    fileprivate func configureUI() {
        view.backgroundColor = .backgroundColor()
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        //
        let stack : UIStackView = {
            let stack = UIStackView.init(arrangedSubviews: [fullnameContainer,
                                                            emailContainer,
                                                            passwordContainer,
                                                            profileoptionContainer,
                                                            signupButton])
            stack.axis = .vertical
            stack.spacing = 20
            stack.distribution = .fillEqually
            return stack
        }()
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-40)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        //
        view.addSubview(backToLoginButton)
        backToLoginButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(8)
            make.height.equalTo(25)
            make.centerX.equalToSuperview()
        }
    }
    
}

//MARK: - selectors

extension Signup {
    
    @objc func openSignIn() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSignUp() {
        guard let email = emailTextField.text,
            let password = passwordTextField.text,
            let fullname = fullnameTextField.text else { return }
        let credentials = UserCredential.init(fullname: fullname,
                                              email: email,
                                              userType: profileOption.selectedSegmentIndex)
        signup(with: credentials, and: password)
        navigationController?.popToRootViewController(animated: true)
    }
    
}

//MARK: - API

extension Signup {
    fileprivate func signup(with credentials : UserCredential, and password : String) {
        signupService.signup(withCredentials: credentials, and: password) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

