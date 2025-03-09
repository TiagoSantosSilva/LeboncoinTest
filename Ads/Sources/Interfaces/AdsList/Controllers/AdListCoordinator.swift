//
//  AdListCoordinator.swift
//  Ads
//
//  Created by Tiago Silva on 09/03/2025.
//

import Pandora
import UIKit

final class AdListCoordinator: Coordinator {
    private let router: FlowRouterProtocol
    private let window: UIWindow

    init(
        router: FlowRouterProtocol,
        window: UIWindow
    ) {
        self.router = router
        self.window = window
        super.init()
    }

    func start() {
        let viewModel = AdListViewModel()
        viewModel.delegate = self
        let viewController = AdListViewController(viewModel: viewModel)
        router.navigationController.setViewControllers([viewController], animated: false)
        window.rootViewController = router.navigationController
        window.makeKeyAndVisible()
    }
}

// MARK: - AdListViewModelDelegate

extension AdListCoordinator: AdListViewModelDelegate {
    func viewModel(_ viewModel: AdListViewModel, didTap ad: Ad) {
        initiate(coordinator: AdDetailsCoordinator(
            ad: ad,
            router: router)
        )
    }
}
