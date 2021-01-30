//
//  ModuleFactory+MainModule.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 20.01.2021.
//

import Foundation

extension ModuleFactory {
    func makeMainModule() -> MainViewController {
        let viewModel = MainViewModel()
        let viewController = MainViewController(viewModel: viewModel)
        viewModel.view = viewController
        return viewController
    }
}
