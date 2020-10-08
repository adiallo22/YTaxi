//
//  UserDataViewModel.swift
//  YTaxi
//
//  Created by Abdul Diallo on 10/8/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Foundation

struct UserDataViewModel {
    
    private let user : UserCredential
    
    var fullname : String {
        return user.fullname
    }
    
    init(user: UserCredential) {
        self.user = user
    }
    
}
