//
//  AdListApiService.swift
//  Ads
//
//  Created by Tiago Silva on 09/03/2025.
//

import Network

protocol AdListApiServiceProtocol {
    func loadAds() async throws -> [AdApiDto]
    func loadCategories() async throws -> [CategoryApiDto]
}

final class AdListApiService: AdListApiServiceProtocol {
    private let networkEngine: NetworkEngineProtocol

    init(networkEngine: NetworkEngineProtocol) {
        self.networkEngine = networkEngine
    }

    convenience init() {
        self.init(networkEngine: NetworkEngine())
    }

    func loadAds() async throws -> [AdApiDto] {
        try await networkEngine.request(
            url: "/listing.json",
            method: .get
        )
    }

    func loadCategories() async throws -> [CategoryApiDto] {
        try await networkEngine.request(
            url: "/categories.json",
            method: .get
        )
    }
}
