//
//  LoginServiceMock.swift
//  YTaxiTests
//
//  Created by Abdul Diallo on 10/6/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Foundation
@testable import YTaxi

class LoginServiceMock {
    
    var shouldReturnError = false
    var loginCalled = false
    var logoutCalled = false
    
    init(_ shouldReturnError : Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
}

//MARK: - <#section heading#>

extension LoginServiceMock : LoginDelegate {
    
    func login(withEmail email: String, and password: String, completion: @escaping (Error?) -> Void) {
        loginCalled = true
        if shouldReturnError {
            completion(LoginError.loginError)
        }
    }
    
    func logout(completion: @escaping (Error?) -> Void) {
        logoutCalled = true
        if shouldReturnError {
            completion(LoginError.logoutError)
        }
    }
    
}

//MARK: - Error

enum LoginError : Error {
    case loginError
    case logoutError
    var description : String {
        switch self {
        case .loginError:
            return "Error logging in"
        case .logoutError:
            return "Error loging out"
        }
    }
}
