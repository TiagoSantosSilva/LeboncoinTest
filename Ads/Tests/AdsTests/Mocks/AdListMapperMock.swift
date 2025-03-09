//
//  AdListMapperMock.swift
//  Ads
//
//  Created by Tiago Silva on 09/03/2025.
//

@testable import Ads

final class AdListMapperMock: AdListMapperProtocol {
    var mapReturnValue: [Ad]!

    func map(
        ads: [Ads.AdApiDto],
        categories: [Ads.CategoryApiDto],
        displayCurrency: String
    ) -> [Ad] {
        mapReturnValue
    }
}
