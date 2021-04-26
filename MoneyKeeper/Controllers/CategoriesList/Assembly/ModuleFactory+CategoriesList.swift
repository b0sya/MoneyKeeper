//
//  ModuleFactory+CategoriesList.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 18.04.2021.
//

import Foundation

protocol CategoriesListModuleFactory {
    func makeCategoriesListModule(direction: DirectionType, showSubcategoriesButton: Bool) -> CategoriesListModule
    func makeCategoriesListModule(mainCategory: FCategory) -> CategoriesListModule
}

extension ModuleFactoryImp: CategoriesListModuleFactory {
    func makeCategoriesListModule(direction: DirectionType, showSubcategoriesButton: Bool) -> CategoriesListModule {
        let viewModel = CategoriesListViewModel(direction: direction, showSubcategoriesButton: showSubcategoriesButton)
        let controller = CategoriesListViewController(viewModel: viewModel)
        
        viewModel.view = controller
        return controller
    }
    
    func makeCategoriesListModule(mainCategory: FCategory) -> CategoriesListModule {
        let viewModel = CategoriesListViewModel(mainCategory: mainCategory)
        let controller = CategoriesListViewController(viewModel: viewModel)
        
        viewModel.view = controller
        return controller
    }
}
