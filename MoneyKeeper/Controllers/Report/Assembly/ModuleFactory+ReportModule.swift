//
//  ModuleFactory+ReportModule.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 25.03.2021.
//

import Foundation

protocol ReportModuleFactory {
    func makeReportModule() -> ReportModule
}

extension ModuleFactoryImp: ReportModuleFactory {
    func makeReportModule() -> ReportModule {
        let viewModel = ReportViewModel()
        let viewController = ReportViewController(viewModel: viewModel)
        
        viewModel.view = viewController
        return viewController
    }
}

