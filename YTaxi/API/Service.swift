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
    
    func fetchUserData() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        userReference.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String:Any] else { return }
            guard let fullname = dictionary["fullname"] as? String else { return }
            
        }
    }
    
}
