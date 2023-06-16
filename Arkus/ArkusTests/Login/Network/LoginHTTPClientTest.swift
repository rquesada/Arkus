//
//  LoginHTTPClientTest.swift
//  ArkusTests
//
//  Created by Roy Quesada on 7/6/23.
//

import XCTest
@testable import Arkus

final class LoginHTTPClientTest: XCTestCase {
    
    var sut: LoginHTTPClient!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        
        
        sut = LoginHTTPClient(urlString: URL.forLogin(), urlSession: urlSession)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
    }
    
    
    func testLoginHTTPClient_WhenGivenSuccessRequest_ShouldReturnSuccess(){
        let loginRequest = LoginRequest(email: "rquesada@arkusnexus.com", password: "hola123")
        let expectation = self.expectation(description: "Login Web Service Response Expectation")
        let loginResponse = LoginResponse(success: true, token: UUID().uuidString, role: "COMMON", uid: UUID().uuidString)
        MockURLProtocol.stubResponseData = try? JSONEncoder().encode(loginResponse)
        
        sut.login(loginRequest){ result in
            switch result {
            case .success( _):
                XCTAssert(true, "Expected signup() response .success")
                expectation.fulfill()
                break
            case .failure(_):
                XCTAssert(false, "Expected signup() response .success but response failure")
                expectation.fulfill()
                break
            }
        }
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testLoginHTTPClient_WhenGivenSuccessRequest_ShouldReturnFail(){
        let loginRequest = LoginRequest(email: "rquesada@arkusnexus.com", password: "hola123")
        let expectation = self.expectation(description: "Login Web Service Response Expectation")
        MockURLProtocol.error = NetworkError.serverError("Bad format")
        
        sut.login(loginRequest){ result in
            switch result {
            case .success( _):
                XCTAssert(false, "Expected login() response .success")
                expectation.fulfill()
                break
            case .failure(_):
                XCTAssert(true, "Expected login() response .success but response failure")
                expectation.fulfill()
                break
            }
        }
        self.wait(for: [expectation], timeout: 5)
    }

}
