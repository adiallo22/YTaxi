//
//  SignupServiceMock.swift
//  YTaxiTests
//
//  Created by Abdul Diallo on 10/6/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Foundation
@testable import YTaxi

class SignupServiceMock {
    
    var shouldReturnError = false
    var signupCalled = false
    
    init(_ shouldReturnError : Bool) {
        self.shouldReturnError = shouldReturnError
    }
}

//MARK: - <#section heading#>

extension SignupServiceMock : SignupDelegate {
    
    func signup(withCredentials credentials: UserCredential, and password: String, completion: @escaping (Error?) -> Void) {
        signupCalled = true
        if shouldReturnError {
            completion(SignupError.signupError)
        }
    }
    
}

//MARK: - Error

enum SignupError : Error {
    case signupError
    var description : String {
        switch self {
        case .signupError:
            return "Error signing up"
        }
    }
}
