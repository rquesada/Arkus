//
//  LoginViewModelTest.swift
//  ArkusTests
//
//  Created by Roy Quesada on 7/6/23.
//

import XCTest
@testable import Arkus

final class LoginViewModelTest: XCTestCase {
    
    var sut: LoginViewModel!
    var mockLoginHTTPClient: MockLoginHTTPClient!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockLoginHTTPClient = MockLoginHTTPClient()
        sut = LoginViewModel(mockLoginHTTPClient)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        mockLoginHTTPClient = nil
    }

    func testLoginViewModel_WhenInformationProvided_WillValidateFieldReturnTrue(){
        
        XCTAssertTrue(sut.isValidLogin("rquesada@arkusnexus.com", "hola123"), "Expected the isValidLogin() return true")
    }
    
    func testLoginViewModel_WhenInformationProvided_WillValidateFieldReturnFalse()
    {
        XCTAssertFalse(sut.isValidLogin("Papa", "hola123"), "Expected the isValidLogin() return false")
    }
    
    func testLoginViewModel_WhenLoginOperationIsExecuted_ShouldCallLoginMethod(){
        
        let expectation = self.expectation(description: "Login Web Service Response Expectation")
        
        sut.login("rquesada@arkusnexus.com", "hola123"){ success in
            XCTAssertTrue(self.mockLoginHTTPClient.isLoginMethodCalled, "Expected the method LoginHTTPClient.login() should be called")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testLoginViewModel_WhenLoginOperationIsExecuted_ShouldReturnSuccess(){
        
        let expectation = self.expectation(description: "Login Web Service Response Expectation")
        
        sut.login("rquesada@arkusnexus.com", "hola123"){ success in
            XCTAssertTrue(success, "Expected the login() return success = true")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 5)
        
    }
    
    func testLoginViewModel_WhenLoginOperationIsExecuted_ShouldReturnFailure(){
        mockLoginHTTPClient.shouldReturnError = true
        let expectation = self.expectation(description: "Login Web Service Response Expectation")
        
        sut.login("rquesada@arkusnexus.com", "hola1234"){ success in
            XCTAssertFalse(success, "Expected the login() return success = true")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 5)
    }
}
