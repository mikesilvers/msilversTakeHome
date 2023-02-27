//
//  ServiceMock.swift
//  msilversTakeHomeTests
//
//  Created by Mike Silvers on 2/26/23.
//

import Combine
import Alamofire
import Foundation

final class ServiceMock: ServiceProtocol {
    
    private let manager: Session
    init(manager: Session = Session.default) {
        self.manager = manager
    }
    
    func fetchUsers() -> AnyPublisher<[User], Alamofire.AFError> {

        return manager.request("https://jsonplaceholder.typicode.com/users", method: .get, parameters: nil, encoding: JSONEncoding.default)
            .validate()
            .publishDecodable(type: [User].self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()

    }
}
