//
//  Service.swift
//  YTaxi
//
//  Created by Abdul Diallo on 10/8/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import FirebaseDatabase
import FirebaseAuth

let userReference = Database.database().reference().child("users")

protocol ServiceProtocol {
    func fetchUserData(completion : @escaping(Result<UserCredential, APIError>) -> Void)
}

struct Service : ServiceProtocol {
    
    func fetchUserData(completion : @escaping(Result<UserCredential, APIError>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        userReference.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String:Any] else {
                completion(.failure(.downcasting(val: "dictionary")))
                return
            }
            let user = UserCredential.init(value: dictionary)
            completion(.success(user))
        }
    }
    
}
