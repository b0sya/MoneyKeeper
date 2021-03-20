//
//  ModuleFactory+CategoriesList.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 20.03.2021.
//

import Foundation

protocol CategoriesListModuleFactory {
    func makeCategoriesListModule(for direction: DirectionType) -> CategoriesListModule
}

extension ModuleFactoryImp: CategoriesListModuleFactory {
    func makeCategoriesListModule(for direction: DirectionType) -> CategoriesListModule {
        let viewModel = CategoriesListViewModel(direction: direction)
        let viewController = CategoriesListViewController(viewModel: viewModel)
        viewModel.view = viewController
        
        return viewController
    }
}
