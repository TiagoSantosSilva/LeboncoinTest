//
//  AdListMapper.swift
//  Ads
//
//  Created by Tiago Silva on 09/03/2025.
//

import Foundation

protocol AdListMapperProtocol {
    func map(
        ads: [AdApiDto],
        categories: [CategoryApiDto],
        displayCurrency: String
    ) -> [Ad]
}

final class AdListMapper: AdListMapperProtocol {
    func map(
        ads: [AdApiDto],
        categories: [CategoryApiDto],
        displayCurrency: String
    ) -> [Ad] {
        let categoryDictionary = Dictionary(uniqueKeysWithValues: categories.map { ($0.id, $0.name) })

        return ads.map { adDto in
            Ad(
                id: adDto.id,
                category: categoryDictionary[adDto.categoryId] ?? "-",
                title: adDto.title,
                description: adDto.description,
                price: "\(adDto.price) \(displayCurrency)",
                images: .init(
                    small: URL(string: adDto.imagesUrl?.small ?? ""),
                    thumbnail: URL(string: adDto.imagesUrl?.thumb ?? "")
                ),
                isUrgent: adDto.isUrgent
            )
        }
    }
}
