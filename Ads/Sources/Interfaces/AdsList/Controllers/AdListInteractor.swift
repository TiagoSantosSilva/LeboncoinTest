//
//  AdListInteractor.swift
//  Ads
//
//  Created by Tiago Silva on 09/03/2025.
//

protocol AdListInteractorProtocol {
    func loadAds(displayCurrency: String) async throws -> [Ad]
}

final class AdListInteractor: AdListInteractorProtocol {
    private let apiService: AdListApiServiceProtocol
    private let mapper: AdListMapperProtocol

    init(
        apiService: AdListApiServiceProtocol,
        mapper: AdListMapperProtocol
    ) {
        self.apiService = apiService
        self.mapper = mapper
    }

    convenience init() {
        self.init(
            apiService: AdListApiService(),
            mapper: AdListMapper()
        )
    }

    func loadAds(displayCurrency: String) async throws -> [Ad] {
        async let adsResult = apiService.loadAds()
        async let categoriesResult = apiService.loadCategories()

        let (ads, categories) = try await (adsResult, categoriesResult)

        return mapper.map(
            ads: ads,
            categories: categories,
            displayCurrency: displayCurrency
        )
    }
}
