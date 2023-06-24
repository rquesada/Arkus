//
//  SignupViewModelTests.swift
//  ArkusTests
//
//  Created by Roy Quesada on 5/6/23.
//

import XCTest
@testable import Arkus

final class SignupViewModelTests: XCTestCase {
    
    var sut: SignupViewModel!
    var mockSignupHTTPClient: MockSignupHTTPClient!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockSignupHTTPClient = MockSignupHTTPClient()
        sut = SignupViewModel(mockSignupHTTPClient)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        mockSignupHTTPClient = nil
    }

    func testSignupViewModel_WhenInformationProvided_WillValidateFieldReturnTrue(){
        //Arrange
        sut.name = "Roy"
        sut.email = "roy.quesada@arkusnexus.com"
        sut.role = Roles.common.rawValue
        sut.password = "123456789"
        sut.repeatPassword = "123456789"
        
        //Assert
        XCTAssertTrue(sut.isValidSignup(), "Expected the isValidSignup() return true")
    }
    
    func testSignupViewModel_WhenInformationProvided_WillValidateFieldReturnFalse(){
        //Arrange
        sut.name = "Roy"
        sut.email = "roy.quesada@arkusnexus.com"
        sut.role = Roles.common.rawValue
        sut.password = "1234567"
        sut.repeatPassword = "123456789"
        
        //Assert
        XCTAssertFalse(sut.isValidSignup(), "Expected the isValidSignup() return true")
    }
    
    func testSignupViewModel_WhenSignupOperationIsExecuted_ShouldCallSignupMethod(){
        //Arrange
        sut.name = "Roy"
        sut.email = "roy.quesada@arkusnexus.com"
        sut.role = Roles.common.rawValue
        sut.password = "hola123"
        sut.repeatPassword = "hola123"
        mockSignupHTTPClient.shouldReturnError = false
        let expectation = self.expectation(description: "Signup Web Service Response Expectation")
        // Act
        sut.signup(){ success in
            XCTAssertTrue(self.mockSignupHTTPClient.isSignupMethodCalled, "Expected the signup() method to be called")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 3)
    }
    
    func testSignupViewModel_WhenSignupOperationIsExecuted_ShouldReturnSuccess(){
        //Arrange
        sut.name = "Roy"
        sut.email = "roy.quesada@arkusnexus.com"
        sut.role = Roles.common.rawValue
        sut.password = "hola123"
        sut.repeatPassword = "hola123"
        mockSignupHTTPClient.shouldReturnError = false
        let expectation = self.expectation(description: "Signup Web Service Response Expectation")
        
        // Act
        sut.signup(){ success in
            XCTAssertTrue(success, "Expected the signup() return success = true")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 3)
    }
    
    func testSignupViewModel_WhenSignupOperationIsExecuted_ShouldReturnError(){
        //Arrange
        sut.name = "Roy"
        sut.email = "roy.quesada@arkusnexus.com"
        sut.role = Roles.common.rawValue
        sut.password = "hola123"
        sut.repeatPassword = "hola1234"
        mockSignupHTTPClient.shouldReturnError = true
        let expectation = self.expectation(description: "Signup Web Service Response Expectation")
        
        // Act
        sut.signup(){ success in
            XCTAssertFalse(success, "Expected the signup() return success = true")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 3)
    }
}
