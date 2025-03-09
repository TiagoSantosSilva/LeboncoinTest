//
//  MockURLSessionDataTask.swift
//  Pandora
//
//  Created by Tiago Silva on 09/03/2025.
//

import Foundation
@testable import Pandora

final class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    var completion: ((Data?, URLResponse?, Error?) -> Void)?
    var originalRequest: URLRequest?
    var resumeHandler: () -> Void = { }
    private(set) var isCancelled = false

    init() {}

    func resume() {
        resumeHandler()
    }

    func cancel() {
        isCancelled = true
    }
}
