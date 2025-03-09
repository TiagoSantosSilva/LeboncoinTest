//
//  NavigationController.swift
//  LeboncoinTest
//
//  Created by Tiago Silva on 08/03/2025.
//

import UIKit

public final class NavigationController: UINavigationController {
    public init() {
        super.init(navigationBarClass: NavigationBar.self, toolbarClass: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        nil
    }
}
