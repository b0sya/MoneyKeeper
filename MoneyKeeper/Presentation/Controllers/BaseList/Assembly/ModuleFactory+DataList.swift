//
//  ModuleFactory+BaseList.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 21.02.2021.
//

import Foundation

protocol BaseListModuleFactory {
    func makeCategoriesListModule() -> BaseListModule
    func makeAccountsListModule() -> BaseListModule
}

extension ModuleFactoryImp: BaseListModuleFactory {
    func makeCategoriesListModule() -> BaseListModule {
        let viewModel = CategoriesListViewModel()
        let viewController = CategoriesListViewController(viewModel: viewModel)
        viewModel.view = viewController
        
        return viewController
    }
    
    func makeAccountsListModule() -> BaseListModule {
        let viewModel = AccountsListViewModel()
        let viewController = AccountsListViewController(viewModel: viewModel)
        viewModel.view = viewController
        
        return viewController
    }
}
