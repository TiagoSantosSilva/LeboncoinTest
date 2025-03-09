//
//  AdDetailsCoordinator.swift
//  Ads
//
//  Created by Tiago Silva on 09/03/2025.
//

import Pandora

final class AdDetailsCoordinator: Coordinator {
    private let ad: Ad
    private let router: FlowRouterProtocol

    init(
        ad: Ad,
        router: FlowRouterProtocol
    ) {
        self.ad = ad
        self.router = router
        super.init()
    }

    func start() {
        let viewModel = AdDetailsViewModel(ad: ad)
        let hostingController = AdDetailsHostingController(viewModel: viewModel)
        router.transition(
            to: hostingController,
            as: .push,
            animated: true
        )
    }
}
