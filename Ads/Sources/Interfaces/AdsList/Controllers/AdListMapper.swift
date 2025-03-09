//
//  AdListMapper.swift
//  Ads
//
//  Created by Tiago Silva on 09/03/2025.
//

import Foundation
import Pandora

protocol AdListMapperProtocol {
    func map(
        ads: [AdApiDto],
        categories: [CategoryApiDto],
        displayCurrency: String
    ) -> [Ad]
}

final class AdListMapper: AdListMapperProtocol {
    private let dateFormatter: DateFormatterProtocol

    init(dateFormatter: DateFormatterProtocol) {
        self.dateFormatter = dateFormatter
    }

    convenience init() {
        self.init(
            dateFormatter: AdListDateFormatter()
        )
    }

    func map(
        ads: [AdApiDto],
        categories: [CategoryApiDto],
        displayCurrency: String
    ) -> [Ad] {
        let categoryDictionary = Dictionary(uniqueKeysWithValues: categories.map { ($0.id, $0.name) })

        return ads.map { adDto in
            let formattedDate = dateFormatter.format(date: adDto.creationDate)

            return Ad(
                id: adDto.id,
                category: categoryDictionary[adDto.categoryId] ?? "-",
                title: adDto.title,
                description: adDto.description,
                price: "\(adDto.price) \(displayCurrency)",
                images: .init(
                    small: URL(string: adDto.imagesUrl?.small ?? ""),
                    thumbnail: URL(string: adDto.imagesUrl?.thumb ?? "")
                ),
                isUrgent: adDto.isUrgent,
                creationDate: formattedDate
            )
        }
    }
}
