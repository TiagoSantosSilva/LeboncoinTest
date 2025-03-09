//
//  AdListApiServiceTests.swift
//  Ads
//
//  Created by Tiago Silva on 09/03/2025.
//

import Testing
@testable import Ads
@testable import Network

@Suite
final class AdListApiServiceTests {
    private var sut: AdListApiService!
    private var networkEngineMock: NetworkEngineMock!
    
    init() {
        networkEngineMock = NetworkEngineMock()
    }
    
    @Test("loadAds calls network engine with correct parameters")
    func testLoadAdsRequestParameters() async throws {
        let mockAds: [AdApiDto] = [
            .sample(id: 1),
            .sample(id: 2)
        ]
        networkEngineMock.setRequestReturnValue(mockAds)
        
        sut = AdListApiService(networkEngine: networkEngineMock)
        
        _ = try await sut.loadAds()
        
        #expect(networkEngineMock.requestCalled)
        #expect(networkEngineMock.lastRequestURL == "/listing.json")
        #expect(networkEngineMock.lastRequestMethod == .get)
    }
    
    @Test("loadAds returns expected data")
    func testLoadAdsReturnsExpectedData() async throws {
        let mockAds: [AdApiDto] = [
            .sample(id: 1),
            .sample(id: 2)
        ]
        networkEngineMock.setRequestReturnValue(mockAds)
        
        sut = AdListApiService(networkEngine: networkEngineMock)
        
        let result = try await sut.loadAds()
        
        #expect(result == mockAds)
    }
    
    @Test("loadAds propagates errors from network engine")
    func testLoadAdsPropagatesErrors() async {
        networkEngineMock.requestError = TestError.someError
        
        sut = AdListApiService(networkEngine: networkEngineMock)
        
        do {
            _ = try await sut.loadAds()
            #expect(Bool(false), "Expected function to throw an error")
        } catch {
            #expect(error is TestError)
            #expect((error as? TestError) == TestError.someError)
        }
    }
    
    @Test("loadCategories calls network engine with correct parameters")
    func testLoadCategoriesRequestParameters() async throws {
        let mockCategories: [CategoryApiDto] = [
            .sample(id: 1, name: "Category 1")
        ]
        networkEngineMock.setRequestReturnValue(mockCategories)
        
        sut = AdListApiService(networkEngine: networkEngineMock)
        
        _ = try await sut.loadCategories()
        
        #expect(networkEngineMock.requestCalled)
        #expect(networkEngineMock.lastRequestURL == "/categories.json")
        #expect(networkEngineMock.lastRequestMethod == .get)
    }
    
    @Test("loadCategories returns expected data")
    func testLoadCategoriesReturnsExpectedData() async throws {
        let mockCategories: [CategoryApiDto] = [
            .sample(id: 1, name: "Category 1")
        ]
        networkEngineMock.setRequestReturnValue(mockCategories)
        
        sut = AdListApiService(networkEngine: networkEngineMock)
        
        let result = try await sut.loadCategories()
        
        #expect(result == mockCategories)
    }
    
    @Test("loadCategories propagates errors from network engine")
    func testLoadCategoriesPropagatesErrors() async {
        networkEngineMock.requestError = TestError.someError
        
        sut = AdListApiService(networkEngine: networkEngineMock)
        
        do {
            _ = try await sut.loadCategories()
            #expect(Bool(false), "Expected function to throw an error")
        } catch {
            #expect(error is TestError)
            #expect((error as? TestError) == TestError.someError)
        }
    }
}
