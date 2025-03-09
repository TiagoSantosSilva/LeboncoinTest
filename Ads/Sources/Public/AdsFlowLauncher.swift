//
//  UIColor+App.swift
//  Ads
//
//  Created by Tiago Silva on 08/03/2025.
//

import Pandora
import UIKit

public protocol AdsFlowLauncherProtocol {
    func runAdsList()
}

public final class AdsFlowLauncher: AdsFlowLauncherProtocol {
    private let coordinator: AdListCoordinator

    public init(
        router: FlowRouterProtocol,
        window: UIWindow
    ) {
        self.coordinator = AdListCoordinator(
            router: router,
            window: window
        )
    }

    public func runAdsList() {
        coordinator.start()
    }
}
