//
//  ModuleFactory+BaseList.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 21.02.2021.
//

import Foundation

protocol BaseListModuleFactory {
    func makeAccountsListModule() -> BaseListModule
}

extension ModuleFactoryImp: BaseListModuleFactory {
    
    func makeAccountsListModule() -> BaseListModule {
        let viewModel = AccountsListViewModel()
        let viewController = AccountsListViewController(viewModel: viewModel)
        viewModel.view = viewController
        
        return viewController
    }
}
