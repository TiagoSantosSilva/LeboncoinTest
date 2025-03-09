//
//  UIColor+App.swift
//  Ads
//
//  Created by Tiago Silva on 08/03/2025.
//

import Pandora
import UIKit

public protocol AdsFlowLauncherProtocol {
    func runAdsList(
        router: FlowRouterProtocol,
        window: UIWindow
    )
}

public final class AdsFlowLauncher: AdsFlowLauncherProtocol {
    public init() {}

    public func runAdsList(
        router: FlowRouterProtocol,
        window: UIWindow
    ) {
        let coordinator = AdListCoordinator(router: router)
        coordinator.start(window: window)
    }
}
