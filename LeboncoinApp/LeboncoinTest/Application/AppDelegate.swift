//
//  AppDelegate.swift
//  LeboncoinTest
//
//  Created by Tiago Silva on 08/03/2025.
//

import Ads
import LeboncoinUIKit
import Network
import Pandora
import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    private lazy var adsLauncher: AdsFlowLauncher = {
        guard let window = window else { fatalError() }
        let navigationController = NavigationController()
        return .init(router: FlowRouter(navigationController: navigationController), window: window)
    }()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        adsLauncher.runAdsList()
        return true
    }
}
