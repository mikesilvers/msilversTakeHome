//
//  MSTMainViewModel.swift
//  msilversTakeHome
//
//  Created by Mike Silvers on 2/24/23.
//

import Combine
import Alamofire
import Foundation

class MSTMainViewModel: ObservableObject {
    
    /// The list of users published after accessed
    @Published var userList: [User]?
    /// The errors, if there any errors, published after the error occurs
    @Published var userError: NetworkError?
    
    /// The cancellable bucket for memory management with Combine
    private var cancellable: AnyCancellable?
    
    /// The data manager creating the ability to mock the data
    var dataManager: ServiceProtocol
    
    /// The main initializer
    init(dataManager: ServiceProtocol = Service.shared) {
        self.dataManager = dataManager
    }
    
    /// The function to retrieve the user list
    func getUserList() {
        
        cancellable = dataManager.fetchUsers()
            .sink(receiveCompletion: {_ in
                
            },
                  receiveValue: { [weak self] (resultIn) in
                
                guard let strongSelf = self else { return }
                
                if let err = resultIn.error {
                    strongSelf.userList = nil
                    strongSelf.userError = err
                } else if let val = resultIn.value {
                    strongSelf.userList = val
                    strongSelf.userError = nil
                }
                
            })
        
    }
}
