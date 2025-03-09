//
//  AdListDateFormatter.swift
//  Ads
//
//  Created by Tiago Silva on 09/03/2025.
//

import Foundation
import Pandora

final class AdListDateFormatter: DateFormatterProtocol {
    private let outputDateFormatter: DateFormatter
    
    init() {
        outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "dd/MM/yyyy 'at' HH:mm:ss"
        outputDateFormatter.locale = Locale(identifier: "en_US_POSIX")
    }
    
    func format(date: Date) -> String {
        outputDateFormatter.string(from: date)
    }
}
