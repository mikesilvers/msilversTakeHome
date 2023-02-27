//
//  UserListAPI.swift
//  msilversTakeHomeTests
//
//  Created by Mike Silvers on 2/26/23.
//

import Combine
import Alamofire
import Foundation

final class UserListAPI {
    
    private let manager: Session
    init(manager: Session = Session.default) {
        self.manager = manager
    }
    
    func getUserList() {
        
        let call = manager.request("https://jsonplaceholder.typicode.com/users", method: .get, parameters: nil, encoding: JSONEncoding.default)

        call
            .validate()
            .publishDecodable(type: [User].self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()

        
    }
}
