//
//  ServiceTest.swift
//  YTaxiTests
//
//  Created by Abdul Diallo on 10/8/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import Quick
import Nimble
@testable import YTaxi

class ServiceTest : QuickSpec {
    
    override func spec() {
        var serviceMock : ServiceMock!
        
        beforeEach {
            serviceMock = ServiceMock(false)
        }
        afterEach {
            serviceMock = nil
        }
        
        describe("when the fetch user data is called ") {
            
            it("should return a user and NO error") {
                serviceMock.fetchUserData { result in
                    switch result {
                    case .success(let user):
                        expect(user.fullname).to(equal("mockfullname"))
                        expect(user.email).to(equal("mockemail"))
                        expect(user.userType).to(equal(0))
                    case .failure(_):
                        print("")
                    }
                }
            }
            //
            describe("and the server is not working") {
                it("should not return an ERROR") {
                    serviceMock.shouldReturnError = true
                    serviceMock.fetchUserData { result in
                        switch result {
                        case .success(_):
                            print("")
                        case .failure(let error):
                            expect(error.description).to(equal(APIError.downServer.description))
                        }
                    }
                }
            }
            
        }
        
    }
    
}
