//
//  AdListMapperTests.swift
//  Ads
//
//  Created by Tiago Silva on 09/03/2025.
//

import Foundation
import Testing
@testable import Ads
@testable import Pandora

@Suite
final class AdListMapperTests {
    private var sut: AdListMapper!
    private var mockDateFormatter: DateFormatterMock!

    init() {
        mockDateFormatter = DateFormatterMock()
        sut = AdListMapper(dateFormatter: mockDateFormatter)
    }

    @Test("Correctly formats date")
    func testDateFormatting() {
        let testDate = Date(timeIntervalSince1970: 1573039134)
        let formattedDate = "06/11/2019 at 11:18:54"
        mockDateFormatter.formatReturnValue = formattedDate

        let ads: [AdApiDto] = [
            .sample(id: 1, categoryId: 10, title: "Ad 1", price: 100.0, creationDate: testDate)
        ]

        let categories: [CategoryApiDto] = [
            .sample(id: 10, name: "Category 1")
        ]

        let result = sut.map(ads: ads, categories: categories, displayCurrency: "EUR")

        let expectedAd: Ad = .sample(
            id: 1,
            category: "Category 1",
            title: "Ad 1",
            price: "100.0 EUR",
            creationDate: formattedDate
        )

        #expect(result[0] == expectedAd)
        #expect(mockDateFormatter.lastDateFormatted == testDate)
    }

    @Test("Maps ads with matching categories")
    func testMappingWithMatchingCategories() {
        let testDate = Date()
        mockDateFormatter.formatReturnValue = "01/01/2023 at 12:00:00"

        let ads: [AdApiDto] = [
            .sample(id: 1, categoryId: 10, title: "Ad 1", price: 100.0, creationDate: testDate)
        ]

        let categories: [CategoryApiDto] = [
            .sample(id: 10, name: "Category 1")
        ]

        let result = sut.map(ads: ads, categories: categories, displayCurrency: "EUR")

        let expectedAd: Ad = .sample(
            id: 1,
            category: "Category 1",
            title: "Ad 1",
            description: "",
            price: "100.0 EUR",
            images: .sample(),
            isUrgent: false,
            creationDate: "01/01/2023 at 12:00:00"
        )

        #expect(result.count == 1)
        #expect(result[0] == expectedAd)
    }

    @Test("Maps multiple ads with multiple categories")
    func testMappingMultipleAdsAndCategories() {
        let testDate = Date()
        mockDateFormatter.formatReturnValue = "01/01/2023 at 12:00:00"

        let ads: [AdApiDto] = [
            .sample(id: 1, categoryId: 10, title: "Ad 1", price: 100.0, creationDate: testDate),
            .sample(id: 2, categoryId: 20, title: "Ad 2", price: 200.0, creationDate: testDate),
            .sample(id: 3, categoryId: 10, title: "Ad 3", price: 300.0, creationDate: testDate)
        ]

        let categories: [CategoryApiDto] = [
            .sample(id: 10, name: "Category 1"),
            .sample(id: 20, name: "Category 2")
        ]

        let result = sut.map(ads: ads, categories: categories, displayCurrency: "USD")

        let expectedAds: [Ad] = [
            .sample(id: 1, category: "Category 1", title: "Ad 1", price: "100.0 USD", creationDate: "01/01/2023 at 12:00:00"),
            .sample(id: 2, category: "Category 2", title: "Ad 2", price: "200.0 USD", creationDate: "01/01/2023 at 12:00:00"),
            .sample(id: 3, category: "Category 1", title: "Ad 3", price: "300.0 USD", creationDate: "01/01/2023 at 12:00:00")
        ]

        #expect(result.count == 3)
        #expect(result == expectedAds)
    }

    @Test("Uses fallback when category not found")
    func testMissingCategoryFallback() {
        let testDate = Date()
        mockDateFormatter.formatReturnValue = "01/01/2023 at 12:00:00"

        let ads: [AdApiDto] = [
            .sample(id: 1, categoryId: 999, title: "Ad 1", price: 100.0, creationDate: testDate)
        ]

        let categories: [CategoryApiDto] = [
            .sample(id: 10, name: "Category 1")
        ]

        let result = sut.map(ads: ads, categories: categories, displayCurrency: "EUR")

        let expectedAd: Ad = .sample(
            id: 1,
            category: "-",
            title: "Ad 1",
            price: "100.0 EUR",
            creationDate: "01/01/2023 at 12:00:00"
        )

        #expect(result.count == 1)
        #expect(result[0] == expectedAd)
    }

    @Test("Correctly maps image URLs")
    func testImageUrlMapping() {
        let testDate = Date()
        mockDateFormatter.formatReturnValue = "01/01/2023 at 12:00:00"

        let smallUrl = "https://example.com/small.jpg"
        let thumbUrl = "https://example.com/thumb.jpg"
        let imagesUrl = AdApiDto.ImagesURL(small: smallUrl, thumb: thumbUrl)

        let ads: [AdApiDto] = [
            .sample(id: 1, categoryId: 10, title: "Ad 1", price: 100.0, imagesUrl: imagesUrl, creationDate: testDate)
        ]

        let categories: [CategoryApiDto] = [
            .sample(id: 10, name: "Category 1")
        ]

        let result = sut.map(ads: ads, categories: categories, displayCurrency: "EUR")

        let expectedAd: Ad = .sample(
            id: 1,
            category: "Category 1",
            title: "Ad 1",
            price: "100.0 EUR",
            images: .sample(
                small: URL(string: smallUrl),
                thumbnail: URL(string: thumbUrl)
            ),
            creationDate: "01/01/2023 at 12:00:00"
        )

        #expect(result.count == 1)
        #expect(result[0] == expectedAd)
    }

    @Test("Handles nil image URLs")
    func testNilImageUrlHandling() {
        let testDate = Date()
        mockDateFormatter.formatReturnValue = "01/01/2023 at 12:00:00"

        let ads: [AdApiDto] = [
            .sample(id: 1, categoryId: 10, title: "Ad 1", price: 100.0, imagesUrl: nil, creationDate: testDate)
        ]

        let categories: [CategoryApiDto] = [
            .sample(id: 10, name: "Category 1")
        ]

        let result = sut.map(ads: ads, categories: categories, displayCurrency: "EUR")

        let expectedAd: Ad = .sample(
            id: 1,
            category: "Category 1",
            title: "Ad 1",
            price: "100.0 EUR",
            images: .sample(small: nil, thumbnail: nil),
            creationDate: "01/01/2023 at 12:00:00"
        )

        #expect(result.count == 1)
        #expect(result[0] == expectedAd)
    }

    @Test("Handles empty image URLs")
    func testEmptyImageUrlHandling() {
        let testDate = Date()
        mockDateFormatter.formatReturnValue = "01/01/2023 at 12:00:00"

        let imagesUrl = AdApiDto.ImagesURL(small: "", thumb: "")

        let ads: [AdApiDto] = [
            .sample(id: 1, categoryId: 10, title: "Ad 1", price: 100.0, imagesUrl: imagesUrl, creationDate: testDate)
        ]

        let categories: [CategoryApiDto] = [
            .sample(id: 10, name: "Category 1")
        ]

        let result = sut.map(ads: ads, categories: categories, displayCurrency: "EUR")

        let expectedAd: Ad = .sample(
            id: 1,
            category: "Category 1",
            title: "Ad 1",
            price: "100.0 EUR",
            images: .sample(small: nil, thumbnail: nil),
            creationDate: "01/01/2023 at 12:00:00"
        )

        #expect(result.count == 1)
        #expect(result[0] == expectedAd)
    }

    @Test("Preserves urgency flag")
    func testUrgencyFlagPreservation() {
        let testDate = Date()
        mockDateFormatter.formatReturnValue = "01/01/2023 at 12:00:00"

        let ads: [AdApiDto] = [
            .sample(id: 1, categoryId: 10, title: "Ad 1", price: 100.0, creationDate: testDate, isUrgent: true),
            .sample(id: 2, categoryId: 10, title: "Ad 2", price: 100.0, creationDate: testDate, isUrgent: false)
        ]

        let categories: [CategoryApiDto] = [
            .sample(id: 10, name: "Category 1")
        ]

        let result = sut.map(ads: ads, categories: categories, displayCurrency: "EUR")

        let expectedAds: [Ad] = [
            .sample(id: 1, category: "Category 1", title: "Ad 1", price: "100.0 EUR", isUrgent: true, creationDate: "01/01/2023 at 12:00:00"),
            .sample(id: 2, category: "Category 1", title: "Ad 2", price: "100.0 EUR", isUrgent: false, creationDate: "01/01/2023 at 12:00:00")
        ]

        #expect(result.count == 2)
        #expect(result == expectedAds)
    }

    @Test("Uses provided display currency")
    func testDisplayCurrency() {
        let testDate = Date()
        mockDateFormatter.formatReturnValue = "01/01/2023 at 12:00:00"

        let ads: [AdApiDto] = [
            .sample(id: 1, categoryId: 10, title: "Ad 1", price: 100.0, creationDate: testDate)
        ]

        let categories: [CategoryApiDto] = [
            .sample(id: 10, name: "Category 1")
        ]

        let resultEUR = sut.map(ads: ads, categories: categories, displayCurrency: "EUR")
        let resultUSD = sut.map(ads: ads, categories: categories, displayCurrency: "USD")
        let resultGBP = sut.map(ads: ads, categories: categories, displayCurrency: "GBP")

        let expectedEUR: Ad = .sample(id: 1, category: "Category 1", title: "Ad 1", price: "100.0 EUR", creationDate: "01/01/2023 at 12:00:00")
        let expectedUSD: Ad = .sample(id: 1, category: "Category 1", title: "Ad 1", price: "100.0 USD", creationDate: "01/01/2023 at 12:00:00")
        let expectedGBP: Ad = .sample(id: 1, category: "Category 1", title: "Ad 1", price: "100.0 GBP", creationDate: "01/01/2023 at 12:00:00")

        #expect(resultEUR[0] == expectedEUR)
        #expect(resultUSD[0] == expectedUSD)
        #expect(resultGBP[0] == expectedGBP)
    }
}
