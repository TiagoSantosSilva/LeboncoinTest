//
//  Ad.swift
//  Ads
//
//  Created by Tiago Silva on 09/03/2025.
//

import Foundation

struct Ad: Hashable {
    let id: Int
    let category: String
    let title: String
    let description: String
    let price: String
    let imageURL: URL?
    let isUrgent: Bool
}
