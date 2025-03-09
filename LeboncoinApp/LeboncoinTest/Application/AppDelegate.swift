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

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        guard let window = window else { return false }

        let adsLauncher = AdsFlowLauncher()
        let navigationController = NavigationController()
        adsLauncher.runAdsList(
            router: FlowRouter(navigationController: navigationController),
            window: window
        )
        return true
    }
}
