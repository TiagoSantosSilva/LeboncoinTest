//
//  URLSession+Protocols.swift
//  Pandora
//
//  Created by Tiago Silva on 09/03/2025.
//

import Foundation

public protocol URLSessionProtocol {
    func dataTask(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

public protocol URLSessionDataTaskProtocol {
    var originalRequest: URLRequest? { get }

    func resume()
    func cancel()
}

extension URLSession: URLSessionProtocol {
    public func dataTask(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        dataTask(with: url) { data, response, error in
            completion(data, response, error)
        }
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
