//
//  ModuleFactory+Settings.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 10.04.2021.
//

import Foundation

protocol SettingsModuleFactory {
    func makeSettingsModule() -> SettingsModule
}

extension ModuleFactoryImp: SettingsModuleFactory {
    func makeSettingsModule() -> SettingsModule {
        let viewModel = SettingsViewModel()
        let controller = SettingsViewController(viewModel: viewModel)
        
        viewModel.view = controller
        return controller
    }
}
