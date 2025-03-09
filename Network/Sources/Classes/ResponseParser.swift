//
//  NetworkResponseParser.swift
//  Network
//
//  Created by Tiago Silva on 08/03/2025.
//

import Foundation

protocol NetworkResponseParserProtocol: AnyObject {
    func parse<T: Decodable>(response: URLResponse, data: Data) throws -> T
}

final class NetworkResponseParser: NetworkResponseParserProtocol {
    private lazy var decoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()

    init() {}

    func parse<T: Decodable>(response: URLResponse, data: Data) throws -> T {
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.urlBuildFail
        }

        guard isResponseSuccessful(response) else { throw NetworkError.noData }
        return try decoder.decode(T.self, from: data)
    }

    // MARK: - Private Functions

    private func isResponseSuccessful(_ response: HTTPURLResponse) -> Bool {
        ResponseCodes.successful.contains(response.statusCode)
    }
}

private extension NetworkResponseParser {
    enum ResponseCodes {
        static let successful: ClosedRange<Int> = 200...299
        static let redirection: ClosedRange<Int> = 300...399
        static let clientError: ClosedRange<Int> = 400...499
        static let serverError: ClosedRange<Int> = 500...599
    }
}
