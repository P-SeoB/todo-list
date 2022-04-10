//
//  TestURLProtocol.swift
//  To-Do_List
//
//  Created by 박진섭 on 2022/04/10.
//

import Foundation

final class TestURLProtocol:URLProtocol {

    static var loadingHandler: ((URLRequest) -> (HTTPURLResponse, Data?, Error?))?
    
    //true를 반환함으로써 URLSession이 모든 URL요청에 대응 할 수 있음.
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    //동일한 request를 반환할 수 있게 재정의 함.
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = TestURLProtocol.loadingHandler else { return }
        let (response, data, error) = handler(request)
        if let data = data {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        }
        else {
            client?.urlProtocol(self, didFailWithError: error!)
        }
    }
    
    override func stopLoading() {}
    
}
