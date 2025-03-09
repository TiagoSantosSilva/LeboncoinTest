//
//  Ad+Sample.swift
//  Ads
//
//  Created by Tiago Silva on 09/03/2025.
//

import Foundation
@testable import Ads

extension Ad {
    static func sample(
        id: Int = 0,
        category: String = "",
        title: String = "",
        description: String = "",
        price: String = "",
        images: Images = .sample(),
        isUrgent: Bool = false
    ) -> Self {
        .init(
            id: id,
            category: category,
            title: title,
            description: description,
            price: price,
            images: images,
            isUrgent: isUrgent
        )
    }
}

extension Ad.Images {
    static func sample(
        small: URL? = nil,
        thumbnail: URL? = nil
    ) -> Self {
        .init(
            small: small,
            thumbnail: thumbnail
        )
    }
}
