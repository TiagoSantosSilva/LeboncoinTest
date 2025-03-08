//
//  NavigationController.swift
//  LeboncoinTest
//
//  Created by Tiago Silva on 08/03/2025.
//

import UIKit

public final class NavigationController: UINavigationController {
    public override init(rootViewController: UIViewController) {
        super.init(navigationBarClass: NavigationBar.self, toolbarClass: nil)
        self.setViewControllers([rootViewController], animated: false)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        nil
    }
}
