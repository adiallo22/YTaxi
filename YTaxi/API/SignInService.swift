//
//  SignInService.swift
//  YTaxi
//
//  Created by Abdul Diallo on 10/12/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Firebase

protocol LoginDelegate {
    func login(withEmail email : String, and password : String,
               completion : @escaping(Error?) -> Void)
    func logout(completion : @escaping (Error?) -> Void)
}

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
                return
            }
            completion(nil)
        }
    }
}
