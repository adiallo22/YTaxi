//
//  AuthenticationService.swift
//  YTaxi
//
//  Created by Abdul Diallo on 10/5/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import Firebase

//MARK: - protocols

protocol LoginDelegate {
    func login(withEmail email : String, and password : String,
               completion : @escaping(Error?) -> Void)
}

protocol SignupDelegate {
    func signup(withCredentials credentials : UserCredential, completion : @escaping(Error?)->Void)
}

//MARK: - Login

struct LoginService : LoginDelegate {
    func login(withEmail email: String, and password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { auth, error in
            if let error = error {
                completion(error)
            }
        }
    }
}

//MARK: - signup

struct SignupService : SignupDelegate {
    func signup(withCredentials credentials : UserCredential, completion : @escaping(Error?)->Void) {
        <#code#>
    }
}
