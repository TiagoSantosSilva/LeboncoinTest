//
//  AdListCoordinator.swift
//  Ads
//
//  Created by Tiago Silva on 09/03/2025.
//

import Pandora
import UIKit

protocol AdListCoordinatorProtocol {
    func start(window: UIWindow)
}

final class AdListCoordinator: AdListCoordinatorProtocol {
    private let router: FlowRouterProtocol

    init(router: FlowRouterProtocol) {
        self.router = router
    }

    func start(window: UIWindow) {
        let viewController = AdListViewController(viewModel: AdListViewModel())
        router.navigationController.setViewControllers([viewController], animated: false)
        window.rootViewController = router.navigationController
        window.makeKeyAndVisible()
    }
}
