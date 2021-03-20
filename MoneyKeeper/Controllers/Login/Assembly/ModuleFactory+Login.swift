//
//  ModuleFactory+Login.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 08.03.2021.
//

import Foundation

protocol LoginModuleFactory {
    func makeLoginModule() -> LoginModule
}

extension ModuleFactoryImp: LoginModuleFactory {
    func makeLoginModule() -> LoginModule {
        let viewModel = LoginViewModel()
        let vc = LoginViewController(viewModel: viewModel)
        viewModel.view = vc
        return vc
    }
}


