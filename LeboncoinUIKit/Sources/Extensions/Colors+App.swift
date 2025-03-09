//
//  Colors+App.swift
//  LeboncoinUIKit
//
//  Created by Tiago Silva on 08/03/2025.
//

import SwiftUI
import UIKit

public extension UIColor {
    enum App {
        public static let background: UIColor = .systemBackground
        public static let cell: UIColor = .systemGray6
        public static let headerbackground: UIColor = .label
        public static let headerLabel: UIColor = .systemBackground
        public static let tint: UIColor = .systemBlue
        public static let label: UIColor = .label
        public static let secondaryLabel: UIColor = .secondaryLabel
        public static let warning: UIColor = .systemOrange
    }
}

public extension Color {
    enum App {
        public static let background = Color(.App.background)
        public static let cell = Color(.App.cell)
        public static let headerBackground = Color(.App.headerbackground)
        public static let headerLabel = Color(.App.headerLabel)
        public static let tint = Color(.App.tint)
        public static let label = Color(.App.label)
        public static let secondaryLabel = Color(.App.secondaryLabel)
        public static let warning: Color = .init(.App.warning)

        public static let cardBackground = Color(UIColor(dynamicProvider: { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ?
                UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1.0) :
                UIColor.systemGray6
        }))
    }
}
