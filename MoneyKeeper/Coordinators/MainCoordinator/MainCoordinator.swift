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

final class MainCoordinator: BaseCoordinator {
    typealias MainCoordinatorModuleFactory = MainModuleFactory & AddTransactionModuleFactory & AccountInfoModuleFactory & ReportModuleFactory
    
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
        
        module.onAccountTap = { [weak self] account in
            self?.showAccountInfo(for: account)
        }

        module.onAddTransaction = { [weak self] in
            self?.runAddTransactionFlow { [weak module] in
                module?.refreshData()
            }
        }
        
        module.onReportTapped = { [weak self, weak module] in
            guard let module = module else { return }
            self?.runReportFlow(currentBalance: module.currentBalance) {
                
            }
        }

        router.setRootModule(module, hideBar: false, animated: true)
    }

    private func runAddTransactionFlow(onFinish: @escaping VoidClosure) {
        let coordinator = coordinatorFactory.makeAddTransactionCoordinator(router: router)
        bind(coordinator, completion: onFinish)
    }

    private func runAddAccountFlow(onFinish: @escaping VoidClosure) {
        let coordinator = coordinatorFactory.makeAddAccountCoordinator(router: router)
        bind(coordinator, completion: onFinish)
    }
    
    private func runReportFlow(currentBalance: Double, onFinish: @escaping VoidClosure) {
        let coordinator = coordinatorFactory.makeReportCoordinator(router: router, currentBalance: currentBalance)
        bind(coordinator, completion: onFinish)
    }
    
    private func showAccountInfo(for account: FAccount) {
        let module = factory.makeAccountInfoModule(account: account)
        router.push(module)
    }
}
