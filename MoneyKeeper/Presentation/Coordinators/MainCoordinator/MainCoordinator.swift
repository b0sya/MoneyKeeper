//
//  MainCoordinator.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 05.02.2021.
//

import Foundation

extension CoordinatorFactory {
    func makeMainCoordinator(router: Router) -> Coordinator {
        MainCoordinator(router: router,
                        factory: moduleFactory,
                        coordinatorFactory: self)
    }
}

typealias MainCoordinatorModuleFactory = MainModuleFactory & AddTransactionModuleFactory

final class MainCoordinator: BaseCoordinator {
    private let factory: MainCoordinatorModuleFactory
    private let router: Router
    private let coordinatorFactory: CoordinatorFactory

    init(router: Router,
         factory: MainCoordinatorModuleFactory,
         coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
    }

    override func start() {
        showMain()
    }

    private func showMain() {
        let module = factory.makeMainModule()

        module.onAddAccount = { [weak self] in
            self?.runAddAccountFlow { [weak module] in
                module?.refreshData()
            }
        }

        module.onAddTransaction = { [weak self] in
            self?.showAddTransaction()
        }

        router.setRootModule(module)
    }

    private func showAddTransaction() {
        let module = factory.makeAddTransactionModule()

        router.push(module)
    }

    private func runAddAccountFlow(onFinish: @escaping VoidClosure) {
        let coordinator = coordinatorFactory.makeAddAccountCoordinator(router: router)
        coordinator.finishFlow = { [weak self] _ in
            onFinish()
            self?.router.popModule()
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
