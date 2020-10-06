//
//  AuthLoginTest.swift
//  YTaxiTests
//
//  Created by Abdul Diallo on 10/6/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Nimble
import Quick
@testable import YTaxi

class AuthLoginTest : QuickSpec {
    
    override func spec() {
        describe("To firebase")  {
            var loginService : LoginServiceMock!
            let email = "johndoe@gmail.com"
            let password = "123456"
            beforeEach {
                loginService = LoginServiceMock(false)
            }
            afterEach {
                loginService = nil
            }
            
            describe("when the server is running properly") {
                context("given the loggin & logout function") {
                    it("should not return any error") {
                        loginService.login(withEmail: email, and: password) { error in
                            expect(error).to(beNil())
                        }
                    }
                    it("should not return any error") {
                        loginService.logout { error in
                            expect(error).to(beNil())
                        }
                    }
                }
            }
            
            describe("when server is not running") {
                context("given the loggin & logout function") {
                    it("should return loggin error") {
                        loginService.shouldReturnError = true
                        loginService.login(withEmail: email, and: password) { error in
                            expect(error?.localizedDescription).toNot(beNil())
                        }
                    }
                    it("should return logout error") {
                        loginService.shouldReturnError = true
                        loginService.logout { error in
                            expect(error?.localizedDescription).toNot(beNil())
                        }
                    }
                }
            }
        }
    }
    
}
