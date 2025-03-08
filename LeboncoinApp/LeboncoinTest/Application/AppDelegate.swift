//
//  AppDelegate.swift
//  LeboncoinTest
//
//  Created by Tiago Silva on 08/03/2025.
//

import Ads
import LeboncoinUIKit
import Network
import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .App.background
        window?.makeKeyAndVisible()
        window?.rootViewController = viewController
        return true
    }
}
