//
//  AdApiDto+Sample.swift
//  Ads
//
//  Created by Tiago Silva on 09/03/2025.
//

import Foundation
@testable import Ads

extension AdApiDto {
    static func sample(
        id: Int = 0,
        categoryId: Int = 0,
        title: String = "",
        price: Double = 0.0,
        description: String = "",
        imagesUrl: AdApiDto.ImagesURL? = nil,
        creationDate: Date = .init(),
        isUrgent: Bool = false
    ) -> Self {
        .init(
            id: id,
            categoryId: categoryId,
            title: title,
            description: description,
            price: price,
            imagesUrl: imagesUrl,
            creationDate: creationDate,
            isUrgent: isUrgent,
            siret: nil
        )
    }
}
