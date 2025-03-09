//
//  View+Spacing.swift
//  LeboncoinUIKit
//
//  Created by Tiago Silva on 09/03/2025.
//

import SwiftUI

public extension View {
    func padding(
        _ edges: Edge.Set = .all,
        spacing: Spacing
    ) -> some View {
        self
            .padding(edges, spacing.rawValue)
    }
}

public extension HStack where Content: View {
    init(
        alignment: VerticalAlignment = .center,
        spacing: Spacing,
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            alignment: alignment,
            spacing: spacing.rawValue,
            content: content
        )
    }
}

public extension VStack where Content: View {
    init(
        alignment: HorizontalAlignment = .center,
        spacing: Spacing,
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            alignment: alignment,
            spacing: spacing.rawValue,
            content: content
        )
    }
}
