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
    
    init(value : [String: Any]) {
        self.fullname = value[UserCredentialEnum.fullname.rawValue] as? String ?? ""
        self.email = value[UserCredentialEnum.email.rawValue] as? String ?? ""
        self.userType = value[UserCredentialEnum.userType.rawValue] as? Int ?? 0
    }
    
    init(fullname: String, email: String, userType: Int) {
        self.fullname = fullname
        self.email = email
        self.userType = userType
    }
    
}

//MARK: - <#section heading#>

enum UserCredentialEnum : String {
    case fullname
    case email
    case userType
}
