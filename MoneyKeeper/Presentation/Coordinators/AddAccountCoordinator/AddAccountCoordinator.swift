//
//  AddCardCoordinator.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 06.02.2021.
//

import Foundation

protocol AddAccountCoordinatorOutput: class {
  var finishFlow: ParameterClosure<Account>? { get set }
}

extension CoordinatorFactory {
    func makeAddAccountCoordinator(router: Router) -> AddAccountCoordinator {
        AddAccountCoordinator(router: router, factory: moduleFactory)
    }
}

final class AddAccountCoordinator: BaseCoordinator, AddAccountCoordinatorOutput {
    private let factory: AddAccountModuleFactory
    private let router: Router

    var finishFlow: ParameterClosure<Account>?

    init(router: Router,
         factory: AddAccountModuleFactory) {
        self.router = router
        self.factory = factory
    }

    override func start() {
        showAddCard()
    }

    private func showAddCard() {
        let module = factory.makeAddAccountModule()

        module.onFinish = { [weak self] account in
            self?.finishFlow?(account)
        }

        router.push(module)
    }
}
