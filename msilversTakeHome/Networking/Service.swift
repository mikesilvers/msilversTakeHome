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
    func fetchUsers() -> AnyPublisher<DataResponse<[User], NetworkError>, Never>
}

class Service {
    static let shared: ServiceProtocol = Service()
    private init() { }
}

extension Service: ServiceProtocol {
    
    func fetchUsers() -> AnyPublisher<DataResponse<[User], NetworkError>, Never> {
        
//        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
//            // there was an error forming the URL
//            return Empty(completeImmediately: true)
//        }

        // NOTE: replace the force unwrap
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!

        return AF.request(url, method: .get)
            .validate()
            .publishDecodable(type: [User].self)
            .map { response in
                response.mapError { error in
                    return NetworkError(initialError: error)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }

}
