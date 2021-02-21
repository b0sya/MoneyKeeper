//
//  ModuleFactory+AddTranaction.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 06.02.2021.
//

import Foundation

protocol AddTransactionModuleFactory {
    func makeAddTransactionModule() -> AddTransactionViewController
}

extension ModuleFactoryImp: AddTransactionModuleFactory {
    func makeAddTransactionModule() -> AddTransactionViewController {
        let viewModel = AddTransactionViewModel()
        let viewController = AddTransactionViewController(viewModel: viewModel)

        viewModel.view = viewController
        return viewController
    }
}

