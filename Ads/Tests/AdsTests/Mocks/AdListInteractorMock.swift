//
//  AdListInteractorMock.swift
//  Ads
//
//  Created by Tiago Silva on 09/03/2025.
//

@testable import Ads

final class AdListInteractorMock: AdListInteractorProtocol {
    var loadAdsReturnValue: [Ad]?
    var loadAdsError: Error?
    var loadAdsCalled = false

    func loadAds(displayCurrency: String) async throws -> [Ad] {
        loadAdsCalled = true

        if let error = loadAdsError {
            throw error
        }

        return loadAdsReturnValue ?? []
    }
}
