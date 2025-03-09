//
//  AdApiDto.swift
//  Ads
//
//  Created by Tiago Silva on 09/03/2025.
//

import Foundation

struct AdApiDto: Decodable, Equatable {
    struct ImagesURL: Decodable, Equatable {
        let small: String?
        let thumb: String?
    }

    let id: Int
    let categoryId: Int
    let title: String
    let description: String
    let price: Double
    let imagesUrl: ImagesURL?
    let creationDate: Date
    let isUrgent: Bool
    let siret: String?

    enum CodingKeys: String, CodingKey {
        case id
        case categoryId = "category_id"
        case title
        case description
        case price
        case imagesUrl = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
        case siret
    }
}
