//
//  NSLayoutAnchor+Spacing.swift
//  LeboncoinUIKit
//
//  Created by Tiago Silva on 09/03/2025.
//

import UIKit

public extension NSLayoutXAxisAnchor {
    func constraint(
        equalTo anchor: NSLayoutXAxisAnchor,
        spacing: Spacing
    ) -> NSLayoutConstraint {
        constraint(
            equalTo: anchor,
            constant: spacing.rawValue
        )
    }

    func constraint(
        greaterThanOrEqualTo anchor: NSLayoutXAxisAnchor,
        spacing: Spacing
    ) -> NSLayoutConstraint {
        constraint(
            greaterThanOrEqualTo: anchor,
            constant: spacing.rawValue
        )
    }

    func constraint(
        lessThanOrEqualTo anchor: NSLayoutXAxisAnchor,
        spacing: Spacing
    ) -> NSLayoutConstraint {
        constraint(
            lessThanOrEqualTo: anchor,
            constant: spacing.rawValue
        )
    }

    func constraint(
        equalTo anchor: NSLayoutXAxisAnchor,
        negativeSpacing spacing: Spacing
    ) -> NSLayoutConstraint {
        constraint(
            equalTo: anchor,
            constant: -spacing.rawValue
        )
    }

    func constraint(
        greaterThanOrEqualTo anchor: NSLayoutXAxisAnchor,
        negativeSpacing spacing: Spacing
    ) -> NSLayoutConstraint {
        constraint(
            greaterThanOrEqualTo: anchor,
            constant: -spacing.rawValue
        )
    }

    func constraint(
        lessThanOrEqualTo anchor: NSLayoutXAxisAnchor,
        negativeSpacing spacing: Spacing
    ) -> NSLayoutConstraint {
        constraint(
            lessThanOrEqualTo: anchor,
            constant: -spacing.rawValue
        )
    }
}

public extension NSLayoutYAxisAnchor {
    func constraint(
        equalTo anchor: NSLayoutYAxisAnchor,
        spacing: Spacing
    ) -> NSLayoutConstraint {
        constraint(
            equalTo: anchor,
            constant: spacing.rawValue
        )
    }
    
    func constraint(
        greaterThanOrEqualTo anchor: NSLayoutYAxisAnchor,
        spacing: Spacing
    ) -> NSLayoutConstraint {
        constraint(
            greaterThanOrEqualTo: anchor,
            constant: spacing.rawValue
        )
    }
    
    func constraint(
        lessThanOrEqualTo anchor: NSLayoutYAxisAnchor,
        spacing: Spacing
    ) -> NSLayoutConstraint {
        constraint(
            lessThanOrEqualTo: anchor,
            constant: spacing.rawValue
        )
    }
    
    func constraint(
        equalTo anchor: NSLayoutYAxisAnchor,
        negativeSpacing spacing: Spacing
    ) -> NSLayoutConstraint {
        constraint(
            equalTo: anchor,
            constant: -spacing.rawValue
        )
    }
    
    func constraint(
        greaterThanOrEqualTo anchor: NSLayoutYAxisAnchor,
        negativeSpacing spacing: Spacing
    ) -> NSLayoutConstraint {
        constraint(
            greaterThanOrEqualTo: anchor,
            constant: -spacing.rawValue
        )
    }
    
    func constraint(
        lessThanOrEqualTo anchor: NSLayoutYAxisAnchor,
        negativeSpacing spacing: Spacing
    ) -> NSLayoutConstraint {
        constraint(
            lessThanOrEqualTo: anchor,
            constant: -spacing.rawValue
        )
    }
}

public extension NSLayoutDimension {
    func constraint(
        equalTo anchor: NSLayoutDimension,
        spacing: Spacing
    ) -> NSLayoutConstraint {
        constraint(
            equalTo: anchor,
            constant: spacing.rawValue
        )
    }
    
    func constraint(
        greaterThanOrEqualTo anchor: NSLayoutDimension,
        spacing: Spacing
    ) -> NSLayoutConstraint {
        constraint(
            greaterThanOrEqualTo: anchor,
            constant: spacing.rawValue
        )
    }
    
    func constraint(
        lessThanOrEqualTo anchor: NSLayoutDimension,
        spacing: Spacing
    ) -> NSLayoutConstraint {
        constraint(
            lessThanOrEqualTo: anchor,
            constant: spacing.rawValue
        )
    }

    func constraint(equalToConstant spacing: Spacing) -> NSLayoutConstraint {
        constraint(equalToConstant: spacing.rawValue)
    }

    func constraint(greaterThanOrEqualToConstant spacing: Spacing) -> NSLayoutConstraint {
        constraint(greaterThanOrEqualToConstant: spacing.rawValue)
    }

    func constraint(lessThanOrEqualToConstant spacing: Spacing) -> NSLayoutConstraint {
        constraint(lessThanOrEqualToConstant: spacing.rawValue)
    }
}
