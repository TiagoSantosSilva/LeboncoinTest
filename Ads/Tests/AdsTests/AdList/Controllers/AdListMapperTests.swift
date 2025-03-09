//
//  AdListMapperTests.swift
//  Ads
//
//  Created by Tiago Silva on 09/03/2025.
//

import Foundation
import Testing
@testable import Ads

@Suite
final class AdListMapperTests {
    private var sut: AdListMapper!

    init() {
        sut = AdListMapper()
    }

    @Test("Maps ads with matching categories")
    func testMappingWithMatchingCategories() {
        let ads: [AdApiDto] = [
            .sample(id: 1, categoryId: 10, title: "Ad 1", price: 100.0)
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
            isUrgent: false
        )

        #expect(result.count == 1)
        #expect(result[0] == expectedAd)
    }

    @Test("Maps multiple ads with multiple categories")
    func testMappingMultipleAdsAndCategories() {
        let ads: [AdApiDto] = [
            .sample(id: 1, categoryId: 10, title: "Ad 1", price: 100.0),
            .sample(id: 2, categoryId: 20, title: "Ad 2", price: 200.0),
            .sample(id: 3, categoryId: 10, title: "Ad 3", price: 300.0)
        ]

        let categories: [CategoryApiDto] = [
            .sample(id: 10, name: "Category 1"),
            .sample(id: 20, name: "Category 2")
        ]

        let result = sut.map(ads: ads, categories: categories, displayCurrency: "USD")

        let expectedAds: [Ad] = [
            .sample(id: 1, category: "Category 1", title: "Ad 1", price: "100.0 USD"),
            .sample(id: 2, category: "Category 2", title: "Ad 2", price: "200.0 USD"),
            .sample(id: 3, category: "Category 1", title: "Ad 3", price: "300.0 USD")
        ]

        #expect(result.count == 3)
        #expect(result == expectedAds)
    }

    @Test("Uses fallback when category not found")
    func testMissingCategoryFallback() {
        let ads: [AdApiDto] = [
            .sample(id: 1, categoryId: 999, title: "Ad 1", price: 100.0)
        ]

        let categories: [CategoryApiDto] = [
            .sample(id: 10, name: "Category 1")
        ]

        let result = sut.map(ads: ads, categories: categories, displayCurrency: "EUR")

        let expectedAd: Ad = .sample(
            id: 1,
            category: "-",
            title: "Ad 1",
            price: "100.0 EUR"
        )

        #expect(result.count == 1)
        #expect(result[0] == expectedAd)
    }

    @Test("Correctly maps image URLs")
    func testImageUrlMapping() {
        let smallUrl = "https://example.com/small.jpg"
        let thumbUrl = "https://example.com/thumb.jpg"
        let imagesUrl = AdApiDto.ImagesURL(small: smallUrl, thumb: thumbUrl)

        let ads: [AdApiDto] = [
            .sample(id: 1, categoryId: 10, title: "Ad 1", price: 100.0, imagesUrl: imagesUrl)
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
            )
        )

        #expect(result.count == 1)
        #expect(result[0] == expectedAd)
    }

    @Test("Handles nil image URLs")
    func testNilImageUrlHandling() {
        let ads: [AdApiDto] = [
            .sample(id: 1, categoryId: 10, title: "Ad 1", price: 100.0, imagesUrl: nil)
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
            images: .sample(small: nil, thumbnail: nil)
        )

        #expect(result.count == 1)
        #expect(result[0] == expectedAd)
    }

    @Test("Handles empty image URLs")
    func testEmptyImageUrlHandling() {
        let imagesUrl = AdApiDto.ImagesURL(small: "", thumb: "")

        let ads: [AdApiDto] = [
            .sample(id: 1, categoryId: 10, title: "Ad 1", price: 100.0, imagesUrl: imagesUrl)
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
            images: .sample(small: nil, thumbnail: nil)
        )

        #expect(result.count == 1)
        #expect(result[0] == expectedAd)
    }

    @Test("Preserves urgency flag")
    func testUrgencyFlagPreservation() {
        let ads: [AdApiDto] = [
            .sample(id: 1, categoryId: 10, title: "Ad 1", price: 100.0, isUrgent: true),
            .sample(id: 2, categoryId: 10, title: "Ad 2", price: 100.0, isUrgent: false)
        ]

        let categories: [CategoryApiDto] = [
            .sample(id: 10, name: "Category 1")
        ]

        let result = sut.map(ads: ads, categories: categories, displayCurrency: "EUR")

        let expectedAds: [Ad] = [
            .sample(id: 1, category: "Category 1", title: "Ad 1", price: "100.0 EUR", isUrgent: true),
            .sample(id: 2, category: "Category 1", title: "Ad 2", price: "100.0 EUR", isUrgent: false)
        ]

        #expect(result.count == 2)
        #expect(result == expectedAds)
    }

    @Test("Uses provided display currency")
    func testDisplayCurrency() {
        let ads: [AdApiDto] = [
            .sample(id: 1, categoryId: 10, title: "Ad 1", price: 100.0)
        ]

        let categories: [CategoryApiDto] = [
            .sample(id: 10, name: "Category 1")
        ]

        let resultEUR = sut.map(ads: ads, categories: categories, displayCurrency: "EUR")
        let resultUSD = sut.map(ads: ads, categories: categories, displayCurrency: "USD")
        let resultGBP = sut.map(ads: ads, categories: categories, displayCurrency: "GBP")

        let expectedEUR: Ad = .sample(id: 1, category: "Category 1", title: "Ad 1", price: "100.0 EUR")
        let expectedUSD: Ad = .sample(id: 1, category: "Category 1", title: "Ad 1", price: "100.0 USD")
        let expectedGBP: Ad = .sample(id: 1, category: "Category 1", title: "Ad 1", price: "100.0 GBP")

        #expect(resultEUR[0] == expectedEUR)
        #expect(resultUSD[0] == expectedUSD)
        #expect(resultGBP[0] == expectedGBP)
    }
}
