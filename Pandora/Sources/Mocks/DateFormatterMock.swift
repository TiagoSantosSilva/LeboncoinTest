//
//  DateFormatterMock.swift
//  Pandora
//
//  Created by Tiago Silva on 09/03/2025.
//

import Foundation

final class DateFormatterMock: DateFormatterProtocol {
    var formatReturnValue = "01/01/2025 at 12:00:00"
    var lastDateFormatted: Date?

    func format(date: Date) -> String {
        lastDateFormatted = date
        return formatReturnValue
    }
}
