//
//  FlowRouter.swift
//  LeboncoinTest
//
//  Created by Tiago Silva on 08/03/2025.
//

import UIKit

protocol FlowRouterProtocol {
    var navigationController: NavigationController { get }

    func dismiss()
    func pop(animated: Bool)
    func transition(
        to viewController: UIViewController,
        as transitionType: FlowRouter.Transition,
        animated: Bool
    )
}

final class FlowRouter: FlowRouterProtocol {
    enum Transition {
        case root
        case push
        case modal
    }

    let navigationController: NavigationController

    init(navigationController: NavigationController) {
        self.navigationController = navigationController
    }

    func dismiss() {
        navigationController.dismiss(animated: true, completion: nil)
    }

    func pop(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }

    func transition(
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
