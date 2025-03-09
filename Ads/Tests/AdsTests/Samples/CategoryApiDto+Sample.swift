//
//  CategoryApiDto+Sample.swift
//  Ads
//
//  Created by Tiago Silva on 09/03/2025.
//

@testable import Ads

extension CategoryApiDto {
    static func sample(
        id: Int = 0,
        name: String = ""
    ) -> CategoryApiDto {
        .init(
            id: id,
            name: name
        )
    }
}
