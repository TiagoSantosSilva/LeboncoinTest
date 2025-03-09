//
//  MockURLSession.swift
//  Pandora
//
//  Created by Tiago Silva on 09/03/2025.
//

import Foundation
@testable import Pandora

final class MockURLSession: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    var lastDataTask: MockURLSessionDataTask?
    var dataTaskHandler: (URL, ((Data?, URLResponse?, Error?) -> Void)?) -> URLSessionDataTaskProtocol = { _, _ in
        fatalError()
    }

    func dataTask(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        dataTaskHandler(url, completion)
    }
}
