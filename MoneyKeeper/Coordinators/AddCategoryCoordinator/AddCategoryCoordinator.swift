//
//  AddCategoryCoordinator.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 17.04.2021.
//

import Foundation

extension CoordinatorFactory {
    func makeAddCategoryCoordinator(router: Router) -> AddCategoryCoordinator {
        AddCategoryCoordinator(router: router, factory: moduleFactory)
    }
}

final class AddCategoryCoordinator: BaseCoordinator {
    typealias AddCategoryFactory = AddCategoryModuleFactory & CategoriesListModuleFactory
    
    private let factory: AddCategoryFactory
    private let router: Router
    
    init(router: Router,
         factory: AddCategoryFactory) {
        self.router = router
        self.factory = factory
    }
    
    override func start() {
        showAddCategory()
    }
    
    private func showAddCategory() {
        let module = factory.makeAddCategoryModule()
        
        module.onFinish = { [weak self] in
            self?.router.popModule()
            self?.onFinishSelf()
        }
        
        module.onParentCategoryTap = { [weak self] in
            self?.showCategoriesList(direction: $0.direction, onCategorySelected: $0.onCategorySelected)
        }
        
        router.push(module)
    }
    
    private func showCategoriesList(direction: DirectionType, onCategorySelected: ParameterClosure<FCategory>?) {
        let module = factory.makeCategoriesListModule(direction: direction, showSubcategoriesButton: false)
        
        module.onCategorySelected = { [weak self] in
            onCategorySelected?($0)
            self?.router.popModule()
        }
        
        router.push(module)
    }
}

