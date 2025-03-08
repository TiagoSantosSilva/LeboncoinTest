//
//  NavigationBar.swift
//  LeboncoinTest
//
//  Created by Tiago Silva on 08/03/2025.
//

import UIKit

final class NavigationBar: UINavigationBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    private func setup() {
        self.prefersLargeTitles = true

        let appearance = NavigationBarAppearance()
        self.standardAppearance = appearance
        self.scrollEdgeAppearance = appearance

        tintColor = .App.tint
    }
}
