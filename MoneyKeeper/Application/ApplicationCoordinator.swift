//
//  ApplicationCoordinator.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 05.02.2021.
//

import Foundation

final class ApplicationCoordinator: BaseCoordinator {
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router

    init(router: Router, coordinatorFactory: CoordinatorFactory) {
      self.router = router
      self.coordinatorFactory = coordinatorFactory
    }

    override func start() {
        runMainFlow()
    }

    private func runMainFlow() {
        let coordinator = coordinatorFactory.makeMainCoordinator(router: router)
        addDependency(coordinator)
        coordinator.start()
    }
}
