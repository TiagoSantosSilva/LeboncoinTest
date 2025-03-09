//
//  AdListInteractorTests.swift
//  Ads
//
//  Created by Tiago Silva on 09/03/2025.
//

import Testing
@testable import Ads

@Suite
final class AdListInteractorTests {
    private var sut: AdListInteractor!
    private var apiServiceMock: AdListApiServiceMock!
    private var mapperMock: AdListMapperMock!

    init() {
        apiServiceMock = AdListApiServiceMock()
        mapperMock = AdListMapperMock()
    }

    @Test("Successfully loads and maps ads")
    func testSuccessfullyLoadsAndMapsAds() async throws {
        let ads: [AdApiDto] = [.sample(id: 1), .sample(id: 2)]
        let categories: [CategoryApiDto] = [.sample(id: 10, name: "Category 1")]
        let mappedAds: [Ad] = [.sample(id: 1), .sample(id: 2)]

        apiServiceMock.loadAdsReturnValue = ads
        apiServiceMock.loadCategoriesReturnValue = categories
        mapperMock.mapReturnValue = mappedAds

        sut = AdListInteractor(
            apiService: apiServiceMock,
            mapper: mapperMock
        )

        let result = try await sut.loadAds(displayCurrency: "USD")

        #expect(apiServiceMock.loadAdsCalled)
        #expect(apiServiceMock.loadCategoriesCalled)
        #expect(result == mappedAds)
    }

    @Test("Propagates error when loadAds fails")
    func testPropagatesErrorWhenLoadAdsFails() async {
        let error = TestError.someError
        apiServiceMock.loadAdsError = error
        apiServiceMock.loadCategoriesReturnValue = []

        sut = AdListInteractor(
            apiService: apiServiceMock,
            mapper: mapperMock
        )

        do {
            _ = try await sut.loadAds(displayCurrency: "USD")
            #expect(Bool(false), "Expected function to throw an error")
        } catch {
            #expect(error as? TestError == TestError.someError)
        }
    }

    @Test("Propagates error when loadCategories fails")
    func testPropagatesErrorWhenLoadCategoriesFails() async {
        let error = TestError.someError
        apiServiceMock.loadCategoriesError = error
        apiServiceMock.loadAdsReturnValue = []

        sut = AdListInteractor(
            apiService: apiServiceMock,
            mapper: mapperMock
        )

        do {
            _ = try await sut.loadAds(displayCurrency: "USD")
            #expect(Bool(false), "Expected function to throw an error")
        } catch {
            #expect(error as? TestError == TestError.someError)
        }
    }
}
