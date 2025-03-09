//
//  NetworkResponseParserTests.swift
//  Network
//
//  Created by Tiago Silva on 08/03/2025.
//

import Foundation
import Testing
@testable import Network

@Suite("NetworkResponseParser")
struct NetworkResponseParserTests {
    @Test("Parse decodable with valid response and data returns decoded object")
    func testParseDecodableWithValidResponseAndData() throws {
        let parser = NetworkResponseParser()
        let responseCode = 200
        let mockUser = MockUser(id: 1, name: "Test User")
        let data = try JSONEncoder().encode(mockUser)
        let response = createHTTPURLResponse(statusCode: responseCode)

        let parsedUser: MockUser = try parser.parse(response: response, data: data)

        #expect(parsedUser.id == mockUser.id)
        #expect(parsedUser.name == mockUser.name)
    }

    @Test("Parse decodable with non-HTTP response throws urlBuildFail error")
    func testParseDecodableWithNonHTTPResponse() throws {
        let parser = NetworkResponseParser()
        let data = "{}".data(using: .utf8)!
        let response = URLResponse()

        #expect(throws: NetworkError.urlBuildFail) {
            let _: MockUser = try parser.parse(response: response, data: data)
        }
    }

    @Test("Parse decodable with server error status code throws noData error")
    func testParseDecodableWithServerErrorStatusCode() throws {
        let parser = NetworkResponseParser()
        let responseCode = 500
        let data = "{}".data(using: .utf8)!
        let response = createHTTPURLResponse(statusCode: responseCode)

        #expect(throws: NetworkError.noData) {
            let _: MockUser = try parser.parse(response: response, data: data)
        }
    }

    @Test("Parse decodable with client error status code throws noData error")
    func testParseDecodableWithClientErrorStatusCode() throws {
        let parser = NetworkResponseParser()
        let responseCode = 404
        let data = "{}".data(using: .utf8)!
        let response = createHTTPURLResponse(statusCode: responseCode)

        #expect(throws: NetworkError.noData) {
            let _: MockUser = try parser.parse(response: response, data: data)
        }
    }

    @Test("Parse decodable with redirection status code throws noData error")
    func testParseDecodableWithRedirectionStatusCode() throws {
        let parser = NetworkResponseParser()
        let responseCode = 302
        let data = "{}".data(using: .utf8)!
        let response = createHTTPURLResponse(statusCode: responseCode)

        #expect(throws: NetworkError.noData) {
            let _: MockUser = try parser.parse(response: response, data: data)
        }
    }

    @Test("Parse decodable with invalid data throws a decoding error")
    func testParseDecodableWithInvalidData() throws {
        let parser = NetworkResponseParser()
        let responseCode = 200
        let invalidData = "{invalid_json}".data(using: .utf8)!
        let response = createHTTPURLResponse(statusCode: responseCode)

        do {
            let _: MockUser = try parser.parse(response: response, data: invalidData)
            #expect(Bool(false), "Should have thrown an error")
        } catch {
            #expect(error is DecodingError)
        }
    }

    @Test("Parse with lower boundary status code (200) successfully decodes")
    func testParseWithLowerBoundaryStatusCode() throws {
        let parser = NetworkResponseParser()
        let responseCode = 200
        let mockUser = MockUser(id: 1, name: "Test User")
        let data = try JSONEncoder().encode(mockUser)
        let response = createHTTPURLResponse(statusCode: responseCode)

        let parsedUser: MockUser = try parser.parse(response: response, data: data)

        #expect(parsedUser.id == mockUser.id)
        #expect(parsedUser.name == mockUser.name)
    }

    @Test("Parse with upper boundary status code (299) successfully decodes")
    func testParseWithUpperBoundaryStatusCode() throws {
        let parser = NetworkResponseParser()
        let responseCode = 299
        let mockUser = MockUser(id: 1, name: "Test User")
        let data = try JSONEncoder().encode(mockUser)
        let response = createHTTPURLResponse(statusCode: responseCode)

        let parsedUser: MockUser = try parser.parse(response: response, data: data)

        #expect(parsedUser.id == mockUser.id)
        #expect(parsedUser.name == mockUser.name)
    }

    @Test("Parse with multiple decodable types works correctly")
    func testParseWithDifferentDecodableTypes() throws {
        let parser = NetworkResponseParser()
        let responseCode = 200

        let mockUser = MockUser(id: 1, name: "Test User")
        let userData = try JSONEncoder().encode(mockUser)
        let userResponse = createHTTPURLResponse(statusCode: responseCode)

        let mockProduct = MockProduct(id: "prod-123", price: 99.99)
        let productData = try JSONEncoder().encode(mockProduct)
        let productResponse = createHTTPURLResponse(statusCode: responseCode)

        let parsedUser: MockUser = try parser.parse(response: userResponse, data: userData)
        #expect(parsedUser.id == mockUser.id)
        #expect(parsedUser.name == mockUser.name)

        let parsedProduct: MockProduct = try parser.parse(response: productResponse, data: productData)
        #expect(parsedProduct.id == mockProduct.id)
        #expect(parsedProduct.price == mockProduct.price)
    }
}

private extension NetworkResponseParserTests {
    struct MockUser: Codable, Equatable {
        let id: Int
        let name: String
    }

    struct MockProduct: Codable, Equatable {
        let id: String
        let price: Double
    }

    func createHTTPURLResponse(statusCode: Int) -> HTTPURLResponse {
        HTTPURLResponse(
            url: URL(string: "https://mocked.com")!,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )!
    }
}
