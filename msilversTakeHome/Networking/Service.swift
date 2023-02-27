//
//  Service.swift
//  msilversTakeHome
//
//  Created by Mike Silvers on 2/24/23.
//

import Combine
import Alamofire
import Foundation

protocol ServiceProtocol {
    func fetchUsers() -> AnyPublisher<[User], AFError>
}

class Service {
    // creating a singleton for this service class
    // Although singletons are not commonly used, this is an instance where a singleton makes sense
    static let shared: ServiceProtocol = Service()
    private init() { }
}

extension Service: ServiceProtocol {
    
    /// The function that fetches users.
    /// - Returns: A publisher with the data response and en error, if one occurs
    func fetchUsers() -> AnyPublisher<[User], AFError> {

        let urlString = "https://jsonplaceholder.typicode.com/users"
        
        // this is a force unwrap and not usually used in code.
        // since the creation of a URL will breakdown into its elements, we know that the URL
        // is properly formed.  Since it is properly formed, there will never be a crash on the
        // force unwrap.
        // If the code is changed and a different URL string is used, then the app will crash and
        // we will see the error.
        let url = URL(string: urlString)!

        return AF.request(url, method: .get, headers: [HTTPHeader(name: "Cache-Control", value: "no-cache")])
            .validate()
            .publishDecodable(type: [User].self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
}
