//
//  NetworkRequestBuilder.swift
//  Network
//
//  Created by Tiago Silva on 08/03/2025.
//

import Foundation

protocol NetworkRequestBuilderProtocol {
    func buildRequest(
        for endpoint: String,
        method: HTTPMethod,
        queryItems: [URLQueryItem]?
    ) throws -> URLRequest
}

struct NetworkRequestBuilder: NetworkRequestBuilderProtocol {

    // MARK: - Functions

    func buildRequest(
        for endpoint: String,
        method: HTTPMethod,
        queryItems: [URLQueryItem]?
    ) throws -> URLRequest {
        var components = URLComponents()
        components.scheme = URLScheme.https.rawValue
        components.host = "raw.githubusercontent.com"
        components.path = "/leboncoin/paperclip/master".appending(endpoint)
        components.queryItems = queryItems

        guard let url = components.url else {
            throw NetworkError.urlBuildFail
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        return request
    }
}
