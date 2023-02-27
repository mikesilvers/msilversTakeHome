//
//  ServiceMock.swift
//  msilversTakeHomeTests
//
//  Created by Mike Silvers on 2/26/23.
//

import Combine
import Alamofire
import Foundation

class ServiceMock {
    
    // MARK: - Singleton creation
    
    /// The main static manager configuration
    private static var managerConfiguration: ManagerConfiguration?
    
    /// Setup the static variables for the singletton to allow mocking
    /// - Parameter managerConfig: The `ManagerConfiguration` used to inject the manager in the singleton
    class func setup(managerConfig: ManagerConfiguration) {
        ServiceMock.managerConfiguration = managerConfig
    }
    
    // supporting structure for the singleton parameters
    struct ManagerConfiguration {
        let manager: Session
    }
    
    // the singleton
    static let shared: ServiceProtocol = ServiceMock()
    
    private init() {
        guard let _ = ServiceMock.managerConfiguration else {
            fatalError("Error: you must call ServiceMock.setup before accessing")
        }
    }
}

extension ServiceMock: ServiceProtocol {
    
    // MARK: - Protocol functions
    
    func fetchUsers() -> AnyPublisher<[User], Alamofire.AFError> {

        // this should not occur because the way we setup the singleton, but, we need the manager not to be optional
        guard let manager = ServiceMock.managerConfiguration?.manager else {
            
            return Fail(error: Alamofire.AFError.sessionDeinitialized).eraseToAnyPublisher()
        }
        
        // return the mocked manager with the mocked session
        return manager.request("https://jsonplaceholder.typicode.com/users", method: .get, parameters: nil, encoding: JSONEncoding.default)
            .validate()
            .publishDecodable(type: [User].self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
