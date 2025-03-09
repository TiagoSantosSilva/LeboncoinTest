//
//  Coordinator.swift
//  Pandora
//
//  Created by Tiago Silva on 09/03/2025.
//

import Foundation

public typealias Coordinator = CoordinatorClass & CoordinatorStartable

public protocol CoordinatorDelegate: AnyObject {
    func coordinatorDidEnd(_ coordinator: CoordinatorClass)
}

public protocol CoordinatorStartable {
    func start()
}

public extension CoordinatorStartable {
    func start() { }
}

public protocol CoordinatorEndable {
    func end()
}

open class CoordinatorClass: NSObject, CoordinatorEndable, CoordinatorDelegate {
    weak var coordinatorDelegate: CoordinatorDelegate?
    lazy var coordinators: [CoordinatorClass] = []

    @discardableResult
    public func initiate(coordinator: Coordinator) -> Coordinator {
        coordinator.coordinatorDelegate = self
        coordinators.append(coordinator)
        coordinator.start()
        return coordinator
    }

    public func end() {
        coordinatorDelegate?.coordinatorDidEnd(self)
    }

    public func coordinatorDidEnd(_ coordinator: CoordinatorClass) {
        coordinators = coordinators.filter { $0 !== coordinator }
    }
}
