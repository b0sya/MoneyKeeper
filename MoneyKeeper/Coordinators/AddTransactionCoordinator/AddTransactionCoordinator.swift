//
//  AddTransactionCoordinator.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 21.02.2021.
//

import UIKit

extension CoordinatorFactory {
    func makeAddTransactionCoordinator(router: Router) -> AddTransactionCoordinator {
        AddTransactionCoordinator(router: router, factory: moduleFactory, coordinatorFactory: self)
    }
}

final class AddTransactionCoordinator: BaseCoordinator {
    typealias AddTransactionCoordinatorModuleFactory = AddTransactionModuleFactory & BaseListModuleFactory & CategoriesListModuleFactory
    
    private let factory: AddTransactionCoordinatorModuleFactory
    private let router: Router
    private let coordinatorFactory: CoordinatorFactory
        
    init(router: Router,
         factory: AddTransactionCoordinatorModuleFactory,
         coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        showAddTransaction()
    }
    
    private func showAddTransaction() {
        let module = factory.makeAddTransactionModule()
        
        module.onFinish = { [weak self] in
            self?.router.popModule()
            self?.onFinishSelf()
        }
        
        module.onAccountTap = { [weak self] completion in
            self?.showAccountsList(onFinish: completion)
        }
        
        module.onCategoryTap = { [weak self] in
            self?.showCategoriesList(direction: $0.direction, onCategorySelected: $0.onCategorySelected)
        }
        
        router.push(module)
    }
    
    
    private func showAccountsList(onFinish: @escaping ParameterClosure<FAccount>) {
        let module = factory.makeAccountsListModule()
        
        module.onItemSelected = { [weak self] in
            self?.router.popModule()
            guard let account = $0 as? FAccount else { return }
            onFinish(account)
        }
        
        module.onAddTapped = { [weak self] in
            self?.runAddAccountFlow { [weak module] in
                module?.refreshData()
            }
        }
        
        router.push(module)
    }
    
    private func showAddAlert(with title: String, message: String, action: @escaping ParameterClosure<String?>) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Готово", style: .default, handler: { _ in
            guard let textField = alertController.textFields?[0] else {
                return
            }
            
            action(textField.text)
        }))
        alertController.addTextField { textField in
            textField.placeholder = "Название"
        }
        
        router.present(alertController)
    }
    
    private func showCategoriesList(direction: DirectionType, onCategorySelected: ParameterClosure<FCategory>?) {
        let module = factory.makeCategoriesListModule(direction: direction, showSubcategoriesButton: true)
        
        module.onCategorySelected = { [weak self] in
            onCategorySelected?($0)
            self?.router.popModule()
        }
        
        module.onSubcategoriesTapped = { [weak self] in
            self?.showSubcategories(mainCategory: $0, onCategorySelected: { [weak self] selected in
                onCategorySelected?(selected)
                self?.router.popModule()
            })
        }
        
        router.push(module)
    }
    
    private func showSubcategories(mainCategory: FCategory, onCategorySelected: ParameterClosure<FCategory>?) {
        let module = factory.makeCategoriesListModule(mainCategory: mainCategory)
        
        module.onCategorySelected = { [weak self] in
            onCategorySelected?($0)
            self?.router.popModule()
        }
        
        router.push(module)
    }
    
    private func runAddAccountFlow(onFinish: @escaping VoidClosure) {
        let coordinator = coordinatorFactory.makeAddAccountCoordinator(router: router)
        bind(coordinator, completion: onFinish)
    }
    
}

