//
//  AdApiDto+Sample.swift
//  Ads
//
//  Created by Tiago Silva on 09/03/2025.
//

@testable import Ads

extension AdApiDto {
    static func sample(
        id: Int = 0,
        categoryId: Int = 0,
        title: String = "",
        price: Double = 0.0,
        description: String = "",
        imagesUrl: AdApiDto.ImagesURL? = nil,
        isUrgent: Bool = false
    ) -> Self {
        .init(
            id: id,
            categoryId: categoryId,
            title: title,
            description: description,
            price: price,
            imagesUrl: imagesUrl,
            creationDate: "2023-01-01",
            isUrgent: isUrgent,
            siret: nil
        )
    }
}
