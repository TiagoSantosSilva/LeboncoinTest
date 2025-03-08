//
//  NetworkEngine.swift
//  Network
//
//  Created by Tiago Silva on 08/03/2025.
//

import Foundation

public protocol NetworkEngineProtocol: AnyObject {
    func cancel(url: String)
    func request<T: Decodable>(
        url: String,
        method: HTTPMethod,
        queryParameters: [URLQueryItem]
    ) async throws -> T
}

public extension NetworkEngineProtocol {
    func request<T: Decodable>(
        url: String,
        method: HTTPMethod
    ) async throws -> T {
        try await request(
            url: url,
            method: method,
            queryParameters: []
        )
    }
}

public final class NetworkEngine: NetworkEngineProtocol {

    // MARK: - Properties

    private let builder: NetworkRequestBuilderProtocol
    private let parser: NetworkResponseParserProtocol
    private let urlSession: URLSession
    private var tasks: [String: Task<(), Never>] = [:]

    // MARK: - Initialization

    init(
        builder: NetworkRequestBuilderProtocol,
        parser: NetworkResponseParserProtocol,
        urlSession: URLSession
    ) {
        self.builder = builder
        self.parser = parser
        self.urlSession = urlSession
    }

    public convenience init() {
        self.init(
            builder: NetworkRequestBuilder(),
            parser: NetworkResponseParser(),
            urlSession: URLSession.shared
        )
    }

    // MARK: - Functions

    public func cancel(url: String) {
        tasks[url]?.cancel()
    }

    public func request<T: Decodable>(
        url: String,
        method: HTTPMethod,
        queryParameters: [URLQueryItem]
    ) async throws -> T {
        let request = try builder.buildRequest(
            for: url,
            method: method,
            queryItems: queryParameters
        )
        let (data, response) = try await urlSession.data(for: request)
        return try parser.parse(
            response: response,
            data: data
        )
    }
}
