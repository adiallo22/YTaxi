//
//  AuthenticationService.swift
//  YTaxi
//
//  Created by Abdul Diallo on 10/5/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

//MARK: - protocols

protocol LoginDelegate {
    func login(withEmail email : String, and password : String,
               completion : @escaping(Error?) -> Void)
    func logout(completion : @escaping (Error?) -> Void)
}

protocol SignupDelegate {
    func signup(withCredentials credentials : UserCredential, and password: String, completion : @escaping(Error?)->Void)
}

//MARK: - Login

struct LoginService : LoginDelegate {
    
    func logout(completion : @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
        } catch let error {
            completion(error)
        }
    }
    
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
    func signup(withCredentials credentials : UserCredential, and password: String, completion : @escaping(Error?)->Void) {
        SignupService.createUser(with: credentials.email, and: password) { error, uid  in
            if let error = error {
                completion(error)
            } else {
                //save user to db here ..
                guard let uid = uid else { return }
                let value = [
                    "email" : credentials.email,
                    "fullname" : credentials.fullname,
                    "userType" : credentials.userType
                ] as [String:Any]
                Database.database().reference().child("users").child(uid).updateChildValues(value) { error, reference in
                    if let error = error {
                        completion(error)
                    }
                }
            }
        }
    }
    
    static func createUser(with email : String, and password : String, completion : @escaping(Error?, String?)->Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(error, nil)
            }
            guard let uid = result?.user.uid else { return }
            completion(nil, uid)
        }
    }
}
