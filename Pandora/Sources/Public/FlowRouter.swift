//
//  FlowRouter.swift
//  LeboncoinTest
//
//  Created by Tiago Silva on 08/03/2025.
//

import UIKit

public protocol FlowRouterProtocol {
    var navigationController: NavigationController { get }

    func dismiss()
    func pop(animated: Bool)
    func transition(
        to viewController: UIViewController,
        as transitionType: FlowRouter.Transition,
        animated: Bool
    )
}

public final class FlowRouter: @preconcurrency FlowRouterProtocol {
    public enum Transition {
        case root
        case push
        case modal
    }

    public let navigationController: NavigationController

    init(navigationController: NavigationController) {
        self.navigationController = navigationController
    }

    @MainActor
    public func dismiss() {
        navigationController.dismiss(animated: true, completion: nil)
    }

    @MainActor
    public func pop(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }

    @MainActor
    public func transition(
        to viewController: UIViewController,
        as transitionType: Transition,
        animated: Bool
    ) {
        switch transitionType {
        case .root:
            navigationController.setViewControllers([viewController], animated: animated)
        case .push:
            navigationController.pushViewController(viewController, animated: animated)
        case .modal:
            navigationController.present(viewController, animated: animated, completion: nil)
        }
    }
}
