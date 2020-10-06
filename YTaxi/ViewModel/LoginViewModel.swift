//
//  LoginViewModel.swift
//  YTaxi
//
//  Created by Abdul Diallo on 10/5/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

struct LoginViewModel {
    
    private var email : String?
    private var password : String?
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    func activateLoginButton() -> Bool {
        return email != "" && password != ""
    }
    
}
