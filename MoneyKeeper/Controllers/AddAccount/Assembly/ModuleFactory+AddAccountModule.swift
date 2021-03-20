//
//  ModuleFactory+AddAccountModule.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 03.02.2021.
//

import Foundation

protocol AddAccountModuleFactory {
    func makeAddAccountModule() -> AddAccountModule
}

extension ModuleFactoryImp: AddAccountModuleFactory {
    func makeAddAccountModule() -> AddAccountModule {
        let viewModel = AddAccountViewModel()
        let viewController = AddAccountViewController(viewModel: viewModel)

        viewModel.view = viewController
        return viewController
    }
}
