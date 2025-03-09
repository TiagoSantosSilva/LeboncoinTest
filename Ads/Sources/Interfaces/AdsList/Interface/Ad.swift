//
//  Ad.swift
//  Ads
//
//  Created by Tiago Silva on 09/03/2025.
//

import Foundation

struct Ad: Hashable {
    struct Images: Hashable {
        let small: URL?
        let thumbnail: URL?
    }
    let id: Int
    let category: String
    let title: String
    let description: String
    let price: String
    let images: Images
    let isUrgent: Bool
}
