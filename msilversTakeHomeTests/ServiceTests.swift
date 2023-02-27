//
//  ServiceTests.swift
//  msilversTakeHomeTests
//
//  Created by Mike Silvers on 2/26/23.
//

import XCTest
@testable import Alamofire

final class ServiceTests: XCTestCase {

    private var userRequest: UserListAPI!
    
    override func setUp() {
        super.setUp()
        
        let manager: Session = {
            let configuration: URLSessionConfiguration = {
                let configuration = URLSessionConfiguration.default
                configuration.protocolClasses = [MockURLProtocol.self]
                return configuration
            }()
            
            return Session(configuration: configuration)
            
        }()

        userRequest = UserListAPI(manager: manager)
        
        userRequest.getUserList()
            
        
    }
    
    override func tearDown() {
        super.tearDown()
        
        userRequest = nil
        
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

}
