//
//  AuthCoordinator.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 08.03.2021.
//

import Foundation

extension CoordinatorFactory {
    func makeAuthCoordinator(router: Router) -> Coordinator {
        AuthCoordinator(router: router, factory: moduleFactory, coordinatorFactory: self)
    }
}

final class AuthCoordinator: BaseCoordinator {
    private let factory: LoginModuleFactory
    private let router: Router
    private let coordinatorFactory: CoordinatorFactory
    
    init(router: Router,
         factory: LoginModuleFactory,
         coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        showAuth()
    }
    
    private func showAuth() {
        let module = factory.makeLoginModule()
        
        module.onSuccessSignIn = { [weak self] in
            self?.runMainFlow()
        }
        
        router.setRootModule(module, hideBar: true)
    }
    
    private func runMainFlow() {
        let coordinator = coordinatorFactory.makeMainCoordinator(router: router)
        
        addDependency(coordinator)
        coordinator.start()
    }
}
