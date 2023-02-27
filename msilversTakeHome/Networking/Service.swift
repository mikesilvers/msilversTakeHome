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
        
        guard let url = URL(string: urlString) else {
            
            // if the URL does not work, send the error
            // the users will get an error that the list was not retrieved
            return Fail(error: Alamofire.AFError.invalidURL(url: urlString)).eraseToAnyPublisher()

        }

        // The `AF` static class uses the default `Session` object for `URLSession` in the background.  AlamoFire encapsulates `URLSession` for network calls.
        return AF.request(url, method: .get, headers: [HTTPHeader(name: "Cache-Control", value: "no-cache")])
            .validate()
            .publishDecodable(type: [User].self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
}
