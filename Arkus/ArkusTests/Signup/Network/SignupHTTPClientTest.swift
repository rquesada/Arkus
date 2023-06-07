//
//  SignupWebserviceTest.swift
//  ArkusTests
//
//  Created by Roy Quesada on 5/6/23.
//

import XCTest
@testable import Arkus

final class SignupHTTPClientTest: XCTestCase {

    var sut: SignupHTTPClient!
    var signupRequest: SignupRequest!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        
        sut = SignupHTTPClient(urlString: URL.forSignup(), urlSession: urlSession)
        signupRequest = SignupRequest(name: "Roy Quesada", email: "rquesada@arkusnexus.com", password: "123456789", role: "123456789")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        signupRequest = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
    }

    func testSignupWebService_WhenGivenSuccessfullResponse_ReturnSuccess(){
        
        //Arrange
        let expectation = self.expectation(description: "Signup Web Service Response Expectation")
        let user = User(name: self.signupRequest.name, email: self.signupRequest.email, role: self.signupRequest.role, status: true, uid: UUID().uuidString)
        let signupResponse = SignupResponse(success: true, user: user)
        MockURLProtocol.stubResponseData = try? JSONEncoder().encode(signupResponse)
        
        //Act
        sut.signup(self.signupRequest){ result in
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
    
    func testSignupWebService_WhenGivenSuccessfullResponse_ReturnFail(){
        //Arrange
        let expectation = self.expectation(description: "Signup Web Service Response Expectation")
        MockURLProtocol.error = NetworkError.serverError("Bad format")
        
        sut.signup(self.signupRequest){ result in
            switch result {
            case .success( _):
                XCTAssert(false, "Expected signup() response .fail and return .success")
                expectation.fulfill()
                break
            case .failure(_):
                XCTAssert(true, "Expected signup() response .fail and return .success")
                expectation.fulfill()
                break
            }
        }
        self.wait(for: [expectation], timeout: 5)
    }
}
