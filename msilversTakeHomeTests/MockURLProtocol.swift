//
//  MockURLProtocol.swift
//  msilversTakeHomeTests
//
//  Created by Mike Silvers on 2/26/23.
//

import Foundation

final class MockURLProtocol: URLProtocol {
    
    enum ResponseType {
        case error(Error)
        case successCode(HTTPURLResponse)
        case successGoodData(Data)
        case successMalformedData(Data)
        case successEmptyData(Data)
        case successNoData(Data)
    }
    
    static var responseType: ResponseType!
    
    private(set) var activeTask: URLSessionTask?
    
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override class func requestIsCacheEquivalent(_ a: URLRequest, to b: URLRequest) -> Bool {
        return false
    }
    
    override func startLoading() {
        
        activeTask = session.dataTask(with: request.urlRequest!)
        // this prevents the actual request from happening
        activeTask?.cancel()
    }
    
    override func stopLoading() {
        activeTask?.cancel()
    }
}

extension MockURLProtocol: URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        
        switch MockURLProtocol.responseType {
        case .successEmptyData(let data):
            client?.urlProtocol(self, didLoad: data)
        case .successGoodData(let data):
            client?.urlProtocol(self, didLoad: data)
        default:
            break
            
        }
        
        client?.urlProtocol(self, didLoad: data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        switch MockURLProtocol.responseType {
        case .error(let error):
            client?.urlProtocol(self, didFailWithError: error)
        case .successCode(let response):
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        default:
            break
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }
    
}

extension MockURLProtocol {

    enum MockError: Error {
        case none
    }
    
    static func responseWithFailure() {
        MockURLProtocol.responseType = MockURLProtocol.ResponseType.error(MockError.none)
    }
    
    static func responseWithStatusCode(code: Int) {
        MockURLProtocol.responseType = MockURLProtocol.ResponseType.successCode(HTTPURLResponse(url: URL(string: "http://any.com")!,
                                                                                            statusCode: code,
                                                                                            httpVersion: nil,
                                                                                            headerFields: nil)!)
    }
    
    static func responseWithGoodData() {
        
        
    }
}
