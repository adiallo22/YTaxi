//
//  UserDataViewModel.swift
//  YTaxi
//
//  Created by Abdul Diallo on 10/8/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Foundation

struct UserDataViewModel {
    
    private let dictionaryData : [String:Any]
    
    var fullname : String {
        if let fn = dictionaryData[UserCredentialEnum.fullname.rawValue] as? String {
            return fn
        }
        return "No User Retreived"
    }
    
    init(dictionaryData: [String:Any]) {
        self.dictionaryData = dictionaryData
    }
    
}
