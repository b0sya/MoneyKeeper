//
//  ModuleFactory+MainModule.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 20.01.2021.
//

import Foundation

protocol MainModuleFactory {
    func makeMainModule() -> MainModule
}

extension ModuleFactoryImp: MainModuleFactory {
    func makeMainModule() -> MainModule {
        let viewModel = MainViewModel()
        let viewController = MainViewController(viewModel: viewModel)

        viewModel.view = viewController
        return viewController
    }
}
