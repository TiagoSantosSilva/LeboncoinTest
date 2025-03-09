//
//  UIViewController+Lifecycle.swift
//  Pandora
//
//  Created by Tiago Silva on 09/03/2025.
//

import UIKit

public extension UIViewController {
    enum Lifecycle {
        case didLoad
        case didAppear
        case didDisappear
        case willAppear
        case willDisappear
    }
}
