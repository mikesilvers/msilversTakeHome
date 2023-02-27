//
//  ServiceTests.swift
//  msilversTakeHomeTests
//
//  Created by Mike Silvers on 2/26/23.
//

import XCTest
import Combine
@testable import Alamofire
@testable import msilversTakeHome

final class ServiceTests: XCTestCase {
    
    // - MARK: Variables
    
    @Published var userList: [User]?
    @Published var userError: AFError?
    
    private var cancellable: AnyCancellable?
    
    // MARK: - Setup and teardown
    
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

        // set the static class
        ServiceMock.setup(managerConfig: ServiceMock.ManagerConfiguration(manager: manager))
        
        
        
    }
    
    override func tearDown() {
        super.tearDown()
        
    }
    
    // MARK: - the tests
    
//    func testGetUserList() throws {
//        
//        // NOTE: At this location, there is an error "Argument type 'any ServiceProtocol' does not conform to expected type 'ServiceProtocol'".  See the README for a full description.
//        let viewModel = MSTMainViewModel(dataManager: ServiceMock.shared)
//        
//        // testing the users - drop the first since it will be an empty array
//        let users = viewModel.$userList
//            .dropFirst()
//
//        // testing the errors
//        let errors = viewModel.$userError
//            .dropFirst()
//        
//        let userArray = try awaitPublisher(users)
//        
//        // write the tests for the users here
//        
//        let errorArray = try awaitPublisher(errors)
//
//        // write the tests for the errors here
//        
//    }

}
