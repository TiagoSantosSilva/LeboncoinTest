//
//  NavigationBarAppearance.swift
//  LeboncoinTest
//
//  Created by Tiago Silva on 08/03/2025.
//

import LeboncoinUIKit
import UIKit

final class NavigationBarAppearance: UINavigationBarAppearance {
    override init(barAppearance: UIBarAppearance) {
        super.init(barAppearance: barAppearance)
    }

    override init(idiom: UIUserInterfaceIdiom) {
        super.init(idiom: idiom)
        setupStyles()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError()
    }

    private func setupStyles() {
        configureWithOpaqueBackground()
        titleTextAttributes = [.foregroundColor: UIColor.App.label]
        largeTitleTextAttributes = [.foregroundColor: UIColor.App.label]
        shadowColor = .clear
        backgroundColor = .App.background
    }
}
