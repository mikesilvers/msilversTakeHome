//
//  ServiceTests.swift
//  msilversTakeHomeTests
//
//  Created by Mike Silvers on 2/26/23.
//

import XCTest
import Combine
@testable import Alamofire

final class ServiceTests: XCTestCase {
    
    // - MARK: Variables
    
    private var serviceMock: ServiceMock!
    
    @Published var userList: [User]?
    @Published var userError: AFError?
    
    private var cancellable: AnyCancellable?
    
    // MARK: - Setup ad teardown
    
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

        serviceMock = ServiceMock(manager: manager)
        
    }
    
    override func tearDown() {
        super.tearDown()
        
        serviceMock = nil
        
    }
    
    // MARK: - the tests
    
    func testGetUserList() throws {
        
        
        
        
        
        
        
    }

}
