//
//  NetworkError.swift
//  msilversTakeHome
//
//  Created by Mike Silvers on 2/24/23.
//

import Alamofire
import Foundation

struct NetworkError: Error {
    let initialError: AFError
}
