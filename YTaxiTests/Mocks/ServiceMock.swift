//
//  ServiceMock.swift
//  YTaxiTests
//
//  Created by Abdul Diallo on 10/8/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
@testable import YTaxi

class ServiceMock : ServiceProtocol {
    
    var fetchUserDataCalled = false
    var shouldReturnError = false
    
    private let userMock = UserCredential.init(fullname: "mockfullname",
                                               email: "mockemail",
                                               userType: 0)
    
    init(_ shouldReturnError : Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    func fetchUserData(completion: @escaping (Result<UserCredential, APIError>) -> Void) {
        fetchUserDataCalled = true
        if shouldReturnError {
            completion(.failure(.downServer))
        } else {
            completion(.success(userMock))
        }
    }
    
}
