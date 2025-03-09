//
//  NetworkEngineMock.swift
//  Network
//
//  Created by Tiago Silva on 09/03/2025.
//

import Foundation

final class NetworkEngineMock: NetworkEngineProtocol {
    var cancelCalled = false
    var requestCalled = false
    var lastCancelledURL: String?
    var lastRequestURL: String?
    var lastRequestMethod: HTTPMethod?
    var lastRequestQueryParameters: [URLQueryItem]?
    var requestReturnValue: Any?
    var requestError: Error?

    private var tasks: [String: Bool] = [:]

    func cancel(url: String) {
        cancelCalled = true
        lastCancelledURL = url
        tasks[url] = true
    }

    func request<T: Decodable>(
        url: String,
        method: HTTPMethod,
        queryParameters: [URLQueryItem]?
    ) async throws -> T {
        requestCalled = true
        lastRequestURL = url
        lastRequestMethod = method
        lastRequestQueryParameters = queryParameters

        if let error = requestError {
            throw error
        }

        guard let value = requestReturnValue as? T else {
            throw NetworkError.decodingFailed
        }

        return value
    }

    func setRequestReturnValue<T: Decodable>(_ value: T) {
        requestReturnValue = value
    }

    func wasURLCancelled(_ url: String) -> Bool {
        tasks[url] == true
    }
}
