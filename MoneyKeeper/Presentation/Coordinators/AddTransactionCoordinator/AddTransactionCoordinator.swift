//
//  AddTransactionCoordinator.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 21.02.2021.
//

import Foundation

protocol AddTransactionCoordinatorOutput: class {
    var finishFlow: VoidClosure? { get set }
}

extension CoordinatorFactory {
    func makeAddTransactionCoordinator(router: Router) -> AddTransactionCoordinator {
        AddTransactionCoordinator(router: router, factory: moduleFactory)
    }
}

final class AddTransactionCoordinator: BaseCoordinator, AddTransactionCoordinatorOutput {
    typealias AddTransactionCoordinatorModuleFactory = AddTransactionModuleFactory & BaseListModuleFactory
    
    private let factory: AddTransactionCoordinatorModuleFactory
    private let router: Router
    
    var finishFlow: VoidClosure?
    
    init(router: Router,
         factory: AddTransactionCoordinatorModuleFactory) {
        self.router = router
        self.factory = factory
    }
    
    override func start() {
        showAddTransaction()
    }
    
    private func showAddTransaction() {
        let module = factory.makeAddTransactionModule()
        
        module.onFinish = { [weak self] in
            self?.finishFlow?()
        }
        
        module.onCategoryTap = { [weak self] completion in
            self?.showCategoriesList(onFinish: completion)
        }
        
        module.onAccountTap = { [weak self] completion in
            self?.showAccountsList(onFinish: completion)
        }
        
        router.push(module)
    }
    
    private func showCategoriesList(onFinish: @escaping ParameterClosure<Category>) {
        let module = factory.makeCategoriesListModule()
        
        module.onItemSelected = { [weak self] in
            self?.router.popModule()
            guard let category = $0 as? Category else { return }
            onFinish(category)
        }
        
        router.push(module)
    }
    
    private func showAccountsList(onFinish: @escaping ParameterClosure<Account>) {
        let module = factory.makeAccountsListModule()
        
        module.onItemSelected = { [weak self] in
            self?.router.popModule()
            guard let account = $0 as? Account else { return }
            onFinish(account)
        }
        
        router.push(module)
    }
    
}

