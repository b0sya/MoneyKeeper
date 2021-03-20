//
//  ModuleFactory+AddTranaction.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 06.02.2021.
//

import Foundation

protocol AddTransactionModuleFactory {
    func makeAddTransactionModule() -> AddTransactionModule
}

extension ModuleFactoryImp: AddTransactionModuleFactory {
    func makeAddTransactionModule() -> AddTransactionModule {
        let viewModel = AddTransactionViewModel()
        let viewController = AddTransactionViewController(viewModel: viewModel)

        viewModel.view = viewController
        return viewController
    }
}

