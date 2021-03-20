//
//  ApplicationCoordinator.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 05.02.2021.
//

import Foundation
import FirebaseAuth

final class ApplicationCoordinator: BaseCoordinator {
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router

    init(router: Router, coordinatorFactory: CoordinatorFactory) {
      self.router = router
      self.coordinatorFactory = coordinatorFactory
    }

    override func start() {
        guard GoogleAuth.isAuthorized else {
            runAuthFlow()
            return
        }
        runMainFlow()
    }

    private func runMainFlow() {
        let coordinator = coordinatorFactory.makeMainCoordinator(router: router)
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func runAuthFlow() {
        let coordinator = coordinatorFactory.makeAuthCoordinator(router: router)
        addDependency(coordinator)
        coordinator.start()
    }
}
