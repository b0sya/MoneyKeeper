//
//  ModuleFactory+AddCategoryModule.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 17.04.2021.
//

import Foundation

protocol AddCategoryModuleFactory {
    func makeAddCategoryModule() -> AddCategoryModule
}

extension ModuleFactoryImp: AddCategoryModuleFactory {
    func makeAddCategoryModule() -> AddCategoryModule {
        let viewModel = AddCategoryViewModel()
        let controller = AddCategoryViewController(viewModel: viewModel)
        
        viewModel.view = controller
        return controller
    }
}
