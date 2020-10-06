//
//  UserCredential.swift
//  YTaxi
//
//  Created by Abdul Diallo on 10/5/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Foundation

struct UserCredential {
    
    var fullname : String
    var email : String
    var userType : Int
    
//    init(value : [String: Any]) {
//        self.fullname = value["fullname"] as? String ?? ""
//        self.email = value["email"] as? String ?? ""
//        self.userType = value["userType"] as? Int ?? 0
//    }
    
    init(fullname: String, email: String, userType: Int) {
        self.fullname = fullname
        self.email = email
        self.userType = userType
    }
    
}
