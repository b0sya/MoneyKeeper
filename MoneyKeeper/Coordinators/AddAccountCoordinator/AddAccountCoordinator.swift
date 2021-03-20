//
//  AddCardCoordinator.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 06.02.2021.
//

import Foundation

extension CoordinatorFactory {
    func makeAddAccountCoordinator(router: Router) -> AddAccountCoordinator {
        AddAccountCoordinator(router: router, factory: moduleFactory)
    }
}

final class AddAccountCoordinator: BaseCoordinator {
    private let factory: AddAccountModuleFactory
    private let router: Router

    init(router: Router,
         factory: AddAccountModuleFactory) {
        self.router = router
        self.factory = factory
    }

    override func start() {
        showAddAccount()
    }

    private func showAddAccount() {
        let module = factory.makeAddAccountModule()

        module.onFinish = { [weak self] in
            self?.router.popModule()
            self?.onFinishSelf()
        }

        router.push(module)
    }
}
