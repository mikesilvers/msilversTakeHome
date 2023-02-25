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
    
    @Published var userList: [User]?
    @Published var userError: NetworkError?
    
    private var cancellable: AnyCancellable?
    
    var dataManager: ServiceProtocol
    
    init(dataManager: ServiceProtocol = Service.shared) {
        self.dataManager = dataManager
    }
    
    func getUserList() {
        
        cancellable = dataManager.fetchUsers()
            .sink(receiveCompletion: {_ in
                
            },
                  receiveValue: { [weak self] (resultIn) in
                
                guard let strongSelf = self else { return }
                
                if let err = resultIn.error {
                    strongSelf.userList = [User]()
                    strongSelf.userError = err
                } else if let val = resultIn.value {
                    strongSelf.userList = val
                    strongSelf.userError = nil
                }
                
            })
        
        // we should not get here - but if we do, send an error
        
    }
}
