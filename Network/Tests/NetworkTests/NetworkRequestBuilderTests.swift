//
//  NetworkRequestBuilderTests.swift
//  Network
//
//  Created by Tiago Silva on 09/03/2025.
//

import Foundation
import Testing
@testable import Network

@Suite
final class NetworkRequestBuilderTests {
    private var sut: NetworkRequestBuilder!
    
    init() {
        sut = NetworkRequestBuilder()
    }
    
    @Test("Builds GET request with correct URL")
    func testBuildGetRequest() throws {
        let request = try sut.buildRequest(
            for: "/test.json",
            method: .get,
            queryItems: nil
        )
        
        #expect(request.url?.absoluteString == "https://raw.githubusercontent.com/leboncoin/paperclip/master/test.json")
        #expect(request.httpMethod == "GET")
    }
    
    @Test("Correctly includes query parameters")
    func testQueryParameters() throws {
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "param1", value: "value1"),
            URLQueryItem(name: "param2", value: "value2")
        ]
        
        let request = try sut.buildRequest(
            for: "/test.json",
            method: .get,
            queryItems: queryItems
        )
        
        let url = request.url?.absoluteString
        #expect(url?.contains("param1=value1") == true)
        #expect(url?.contains("param2=value2") == true)
        #expect(url?.contains("https://raw.githubusercontent.com/leboncoin/paperclip/master/test.json") == true)
    }
    
    @Test("Handles special characters in URL path")
    func testSpecialCharactersInPath() throws {
        let endpoint = "/test with space.json"
        
        let request = try sut.buildRequest(
            for: endpoint,
            method: .get,
            queryItems: nil
        )
        
        #expect(request.url?.absoluteString == "https://raw.githubusercontent.com/leboncoin/paperclip/master/test%20with%20space.json")
    }
    
    @Test("Handles special characters in query parameters")
    func testSpecialCharactersInQueryParams() throws {
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "param", value: "value with space")
        ]
        
        let request = try sut.buildRequest(
            for: "/test.json",
            method: .get,
            queryItems: queryItems
        )
        
        let url = request.url?.absoluteString
        #expect(url?.contains("param=value%20with%20space") == true)
    }
}
