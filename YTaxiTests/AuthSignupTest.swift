//
//  AuthSignupService.swift
//  YTaxiTests
//
//  Created by Abdul Diallo on 10/6/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import YTaxi

class AuthSignupTest : QuickSpec {
    
    override func spec() {
        describe("To Firebase") {
            var signupServiceMock : SignupServiceMock!
            var signupService : SignupService!
            
            let credentialsMock = UserCredential.init(fullname: "",
                                                      email: "",
                                                      userType: 0)
            
            beforeEach {
                signupService = SignupService()
                signupServiceMock = SignupServiceMock(false)
            }
            afterEach {
                signupServiceMock = nil
                signupService = nil
            }
            
            describe("the server is up and running") {
                context("when signup is executed") {
                    it("should NOT return any error") {
                        signupServiceMock.signup(withCredentials: credentialsMock, and: "") { error in
                            expect(error).toNot(beNil())
                            expect(signupServiceMock.signupCalled).to(beTrue())
                        }
                    }
                }
            }
            
            describe("the server is NOT running") {
                context("when signup is executed") {
                    it("should return an error") {
                        signupServiceMock.shouldReturnError = true
                        signupServiceMock.signup(withCredentials: credentialsMock, and: "") { error in
                            expect(error).toNot(beNil())
                            expect(signupServiceMock.signupCalled).to(beTrue())
                        }
                    }
                }
            }
            
        }
    }
    
}
