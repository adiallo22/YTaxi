//
//  Service.swift
//  YTaxi
//
//  Created by Abdul Diallo on 10/8/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import FirebaseDatabase
import FirebaseAuth

struct Service {
    
    let userReference = Database.database().reference().child("users")
    
    func fetchUserData(completion : @escaping(Result<String, APIError>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        userReference.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String:Any] else {
                completion(.failure(.downcasting(val: "dictionary")))
                return
            }
            guard let fullname = dictionary[UserCredentialEnum.fullname.rawValue] as? String else {
                completion(.failure(.downcasting(val: UserCredentialEnum.fullname.rawValue)))
                return
            }
            completion(.success(fullname))
        }
    }
    
}
