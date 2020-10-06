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
            var loginServiceMock : LoginServiceMock!
            var loginService : LoginService!
            let email = "johndoe@gmail.com"
            let password = "123456"
            let fakeEmail = "1@1.com"
            
            beforeEach {
                loginServiceMock = LoginServiceMock(false)
                loginService = LoginService()
            }
            afterEach {
                loginServiceMock = nil
                loginService = nil
            }
            
            describe("when the server is running properly") {
                context("given the loggin & logout function") {
                    it("should NOT return any error") {
                        loginServiceMock.login(withEmail: "", and: "") { error in
                            expect(error).to(beNil())
                            expect(loginServiceMock.loginCalled).to(beTrue())
                        }
                    }
                    it("should NOT return any error") {
                        loginServiceMock.logout { error in
                            expect(error).to(beNil())
                            expect(loginServiceMock.logoutCalled).to(beTrue())
                        }
                    }
                }
            }
            
            describe("when server is NOT running") {
                context("given the loggin & logout function") {
                    it("should return loggin error") {
                        loginServiceMock.shouldReturnError = true
                        loginServiceMock.login(withEmail: email, and: password) { error in
                            expect(error?.localizedDescription).toNot(beNil())
                            expect(loginServiceMock.loginCalled).to(beTrue())
                        }
                    }
                    it("should return logout error") {
                        loginServiceMock.shouldReturnError = true
                        loginServiceMock.logout { error in
                            expect(error?.localizedDescription).toNot(beNil())
                            expect(loginServiceMock.logoutCalled).to(beTrue())
                        }
                    }
                }
            }
            
            describe("") {
                context("when login with real authentication data") {
                    it("should log user in and not return any error") {
                        loginService.login(withEmail: email, and: password) { error in
                            expect(error).to(beNil())
                        }
                    }
                }
                context("when loggin with fake authentication data") {
                    it("should NOT log user in and should return wrong credentials type error") {
                        loginService.login(withEmail: fakeEmail, and: password) { error in
                            expect(error).toNot(beNil())
                        }
                    }
                }
            }
            
        }
    }
    
}
