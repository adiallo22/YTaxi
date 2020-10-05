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

protocol AuthenticationDelegate {
    func login(withEmail email : String, and password : String,
               completion : @escaping(Error?) -> Void)
}

//MARK: - Login

struct AuthenticationService : AuthenticationDelegate {
    
    private init() { }
    
    func login(withEmail email: String, and password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { auth, error in
            if let error = error {
                completion(error)
            }
        }
    }
    
}

//MARK: - signup
